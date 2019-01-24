extends Path2D

# Custom variables
export (float) var random_angle_range = 30

# References
onready var mob_rsc = preload("res://game/character/enemy/Mob.tscn")
onready var path_follow = $PathFollow


# Custom functions
func spawn_random():
	path_follow.set_unit_offset(rand_range(0, 1))
	
	var spawn_pos = path_follow.position
	var spawn_dir = path_follow.rotation + PI / 2
	var rad = deg2rad(random_angle_range)	# add some random angle
	spawn_dir += rand_range(-rad, rad)
	
	# spawn
	var mob = mob_rsc.instance()
	add_child(mob)
	mob.position = spawn_pos
	mob.rotation = spawn_dir
	mob.set_axis_velocity(Vector2(mob.speed, 0).rotated(mob.rotation))


func disable_collision_once():
	get_tree().call_group("enemy", "disable_collision", true)
