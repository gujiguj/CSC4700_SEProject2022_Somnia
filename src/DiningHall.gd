extends "res://Location.gd"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
# queues up flavor text
# sets up choices
func _ready():
	flavor = [
		"You walk into the Dining Hall",
		"You can always count on this place being jam packed with students at almost any hour.",
		"What would you like to eat??"
	]
	hide_choices()
	choice1.text = "Eat a salad and some fruit"
	choice2.text = "Eat a chicken sandwich and fries"
	choice3.text = "Have two number 9s, a number 9 large, a number 6 with extra dip, a number 7, two number 45s, one with cheese, and a large soda."

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# Eat a salad and fruit
func _on_Choice1_pressed():
	hide_choices()
	var dialog = [
		"You eat a fresh salad and some incredibly juicy fruit. Delectable!"
	]
	emit_signal("queued_dialog", dialog)
	# choice1.disabled = true
	emit_signal("passed_time", 0.25)
	emit_signal("gained_energy", 15)
	emit_signal("gained_happiness", 5)
	
# Eat a chicken sammich and fries
func _on_Choice2_pressed():
	hide_choices()
	var dialog = [
		"You have a chicken sandiwch with fries. The fries are extra crispy today!"
	]
	emit_signal("queued_dialog", dialog)
	#choice2.disabled = true
	emit_signal("passed_time", 0.5)
	emit_signal("gained_energy", 20)
	emit_signal("gained_happiness", 10)
	
# Commence the feast of the Gods
func _on_Choice3_pressed():
	hide_choices()
	var dialog = [
		"You decide to eat your weight in various foods, treating this meal like it's Thanksgiving.",
		"Not the smartest move for your stomach, but WORTH IT."
	]
	emit_signal("queued_dialog", dialog)
	# choice3.disabled = true
	emit_signal("passed_time", 1.5)
	emit_signal("gained_energy", 30)
	emit_signal("gained_happiness", 20)
