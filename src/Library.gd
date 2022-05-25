extends "res://Location.gd"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
# queues up flavor text
# sets up choices
func _ready():
	flavor = [
		"You walk into the library.",
		"Since it's still the start of the year, there aren't many students yet.",
		"What do you want to do?"
	]
	hide_choices()
	choice1.text = "Study for 30 minutes"
	choice2.text = "Do homework for an hour"
	choice3.text = "Read a book for 30 minutes"

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# Study for 30 minutes
# Infinite choice
func _on_Choice1_pressed():
	hide_choices()
	var dialog = [
		"You decide to study for 30 minutes. Nice!"
	]
	emit_signal("queued_dialog", dialog)
	# choice1.disabled = true
	emit_signal("passed_time", 0.5)
	emit_signal("lost_energy", 5)
	emit_signal("lost_happiness", 10)
	
# Do homework for an hour
func _on_Choice2_pressed():
	hide_choices()
	var dialog = [
		"You do your homework for an hour. It's hard, but you get through it."
	]
	emit_signal("completed_task", "Homework")
	emit_signal("queued_dialog", dialog)
	choice2.disabled = true
	emit_signal("passed_time", 1.0)
	emit_signal("lost_energy", 10)
	emit_signal("lost_happiness", 5.0)
	
# Read a book for 30 minutes. Infinite choice
func _on_Choice3_pressed():
	hide_choices()
	var dialog = [
		"You pick up and read an interesting book for 30 minutes. How intellectual!"
	]
	emit_signal("queued_dialog", dialog)
	# choice3.disabled = true
	emit_signal("passed_time", 0.5)
	emit_signal("lost_energy", 5)
	emit_signal("gained_happiness", 5)
