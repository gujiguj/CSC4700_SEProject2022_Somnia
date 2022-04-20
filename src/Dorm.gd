extends "res://Location.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal end_day

# Called when the node enters the scene tree for the first time.
func _ready():
	flavor = [
		"Home sweet home."
	]
	hide_choices()
	choice1.text = "Play video games for 1 hour"
	choice2.text = "Nap for 30 minutes"
	choice3.text = "End the day"

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# Play video games for 1h
# Infinite choice
func _on_Choice1_pressed():
	hide_choices()
	var dialog = [
		"You decide to play video games for 1 hour."
	]
	emit_signal("queued_dialog", dialog)
	# choice1.disabled = true
	emit_signal("passed_time", 1.0)
	emit_signal("lost_energy", 5)
	emit_signal("gained_happiness", 10)
	
# Nap for 30 minutes
func _on_Choice2_pressed():
	hide_choices()
	var dialog = [
		"Naptime... zzz..."
	]
	emit_signal("queued_dialog", dialog)
	emit_signal("passed_time", 0.5)
	emit_signal("gained_energy", 5)
	
# End the day
func _on_Choice3_pressed():
	$Background/EndDayConfirmation.popup()
	yield($Background/EndDayConfirmation, "confirmed")
	hide_choices()
	$Background.set_texture(load("res://backgrounds/dormnightbg.png"))
	var dialog = [
		"You don't leave your dorm for the rest of the day."
	]
	emit_signal("queued_dialog", dialog)
	emit_signal("end_day")
