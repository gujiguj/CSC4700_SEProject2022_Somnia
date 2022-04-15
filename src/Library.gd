extends "res://Location.gd"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	dialog = [
		"You walk into the library.",
		"Since it's still the start of the year, there aren't many students yet.",
		"What do you want to do?"
	]
	hideChoices()
	choice1.text = "Study for 30 minutes"
	choice2.text = "Do homework for 30 minutes"
	choice3.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# Study for 15 minutes
func _on_Choice1_pressed():
	hideChoices()
	dialog = [
		"You decide to study for 30 minutes. Nice!"
	]
	emit_signal("queued_dialog", dialog)
	choice1.disabled = true
	emit_signal("passed_time", 0.5)
	emit_signal("lost_happiness", 5)
	
func _on_Choice2_pressed():
	hideChoices()
	dialog = [
		"You do your homework for 30 minutes. It's hard, but you get through it."
	]
	emit_signal("queued_dialog", dialog)
	choice2.disabled = true
	emit_signal("passed_time", 0.5)
	emit_signal("lost_happiness", 10)
