extends CanvasLayer

# Reference
onready var label_survive_time = $LabelSurviveTime
onready var label_message = $LabelMessage
onready var button_start = $ButtonStart

# Signals
signal start_pressed


# Custom functions
func show_init():
	label_survive_time.hide()
	show_message("Small Fun Game")
	show_button("Play")


func show_start():
	label_survive_time.hide()
	show_message("Doge the Creeps!")
	button_start.hide()


func show_play():
	label_survive_time.show()
	label_message.hide()
	button_start.hide()


func show_end():
	label_survive_time.hide()
	show_message("Time survived: " + label_survive_time.text)
	show_button("Try again")


func update_survive_time(time):
	label_survive_time.text = str(time)


func show_message(text):
	label_message.text = text
	label_message.show()


func show_button(text):
	button_start.text = text
	button_start.show()


# Slots
func _on_ButtonStart_pressed():
	emit_signal("start_pressed")
