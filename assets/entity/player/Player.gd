extends Area2D

# Custom properties
export (int) var speed = 400

# Sigals
signal hit

# Referernces
onready var viewport_size = get_viewport_rect().size
onready var animated_sprite = $AnimatedSprite
onready var collision_shape = $CollisionShape2D

# Helper variables
enum LAST_PRESSED {R, L, U, D}
var last_pressed


func _ready():
	reset()	# just entered tree, reset and wait to call start


func _process(delta):
	# Handle inputs
	var mov = Vector2()
	
	if Input.is_action_pressed("ui_right"):
		mov.x += 1
		last_pressed = LAST_PRESSED.R
	if Input.is_action_pressed("ui_left"):
		mov.x -= 1
		last_pressed = LAST_PRESSED.L
	if Input.is_action_pressed("ui_up"):
		mov.y -= 1
		last_pressed = LAST_PRESSED.U
	if Input.is_action_pressed("ui_down"):
		mov.y += 1
		last_pressed = LAST_PRESSED.D
		
	# Move and Play animation
	mov = mov.normalized() * speed * delta
	process_movement(mov, 1)


# Custom functions
func reset():
	# reset player to center, hide it and disable collision detect
	self.position = viewport_size / 2
	hide()
	collision_shape.disabled = true


func start():
	# after reset, will call this when timer's fire end signal
	show()
	collision_shape.disabled = false


# Helper fuctions
func process_movement(mov, flag=0):
	# move
	self.position += mov
	self.position.x = clamp(self.position.x, 0, viewport_size.x)	# prevent go outside
	self.position.y = clamp(self.position.y, 0, viewport_size.y)
	
	# animation
	# style 1: animation will stay at the last state as it was
	if flag == 0:
		if mov.length() == 0:
			animated_sprite.stop()
			return
		
		match last_pressed:
			LAST_PRESSED.U:
				animated_sprite.play("up")
				animated_sprite.flip_v = false		
			LAST_PRESSED.D:
				animated_sprite.play("up")
				animated_sprite.flip_v = true
			LAST_PRESSED.R:
				animated_sprite.play("right")
				animated_sprite.flip_h = false
			LAST_PRESSED.L:
				animated_sprite.play("right")
				animated_sprite.flip_h = true
				
	# style 2: animation will always flip back such that the head face upwards,
	#          except for the case that the player has +y velocity
	elif flag == 1:
		if mov.length() == 0:	# idle
			animated_sprite.play("up")
			animated_sprite.flip_v = false
			animated_sprite.stop()
			return
		
		if mov.x != 0:
			animated_sprite.play("right")
			animated_sprite.flip_h = mov.x < 0
		else:
			animated_sprite.play("up")
			animated_sprite.flip_v = mov.y > 0


# Slots
func _on_Player_body_entered(body):
	if body.is_in_group("enemy"):
		emit_signal("hit")	# send signal to main, let main scene take control the actions
