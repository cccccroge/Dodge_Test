extends Node

# References
onready var timer_start_freeze = $TimerStartFreeze
onready var timer_spawn_mob = $TimerSpawnMob
onready var timer_score_increment = $TimerScoreIncrement
onready var player = $Player
onready var mob_spawner = $MobSpawnPath
onready var hud = $HUD
onready var background_music = $BackgroundMusic
onready var gameover_sound = $GameoverSound

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
	background_music.play()


func game_play():
	timer_spawn_mob.start()
	timer_score_increment.start()
	hud.show_play()


func add_survive_time():
	survive_time += 1
	hud.update_survive_time(survive_time)


func game_over():
	player.reset()
	mob_spawner.disable_collision_once()
	timer_spawn_mob.stop()
	timer_score_increment.stop()
	hud.show_end()
	background_music.stop()
	gameover_sound.play()


# Slots
func _on_Player_hit():
	game_over()


func _on_TimerStartFreeze_timeout():
	game_play()


func _on_TimerScoreIncrement_timeout():
	add_survive_time()


func _on_TimerSpawnMob_timeout():
	mob_spawner.spawn_random()


func _on_HUD_start_pressed():
	game_start()
