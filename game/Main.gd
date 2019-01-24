extends Node

# References
onready var timer_start_freeze = $TimerStartFreeze
onready var timer_spawn_mob = $TimerSpawnMob
onready var timer_score_increment = $TimerScoreIncrement
onready var player = $Player
onready var mob_spawner = $MobSpawnPath
onready var hud = $HUD

# Custom variables
var survive_time


func _ready():
	randomize()
	game_init()


# Custom functions
func game_init():
	hud.show_init()


func game_start():
	player.start()
	timer_start_freeze.start()
	survive_time = 0
	hud.update_survive_time(survive_time)
	hud.show_start()


func game_over():
	player.reset()
	timer_spawn_mob.stop()
	timer_score_increment.stop()
	hud.show_end()


# Slots
func _on_Player_hit():
	game_over()


func _on_TimerStartFreeze_timeout():
	timer_spawn_mob.start()
	timer_score_increment.start()
	hud.show_play()


func _on_TimerScoreIncrement_timeout():
	survive_time += 1
	hud.update_survive_time(survive_time)


func _on_TimerSpawnMob_timeout():
	mob_spawner.spawn_random()


func _on_HUD_start_pressed():
	game_start()
