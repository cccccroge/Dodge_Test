extends RigidBody2D

# Custom variables
export (int) var speed_max = 300
export (int) var speed_min = 200

# References
onready var animated_sprite = $AnimatedSprite
onready var collision_shape = $CollisionShape2D

# Helper variables
var speed
var type = ["fly", "swim", "walk"]	# map to animation name in AnimatedSprite


func _ready():
	# Set random type and speed when spawn
	var random_type = randi() % type.size()
	animated_sprite.play(type[random_type])
	
	speed = rand_range(speed_min, speed_min)


# Custom functions
func disable_collision(boolean):
	collision_shape.disabled = boolean


# Slots
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
