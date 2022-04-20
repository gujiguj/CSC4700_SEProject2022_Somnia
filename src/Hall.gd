extends "res://Location.gd"

var time_until_class = 0

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	flavor = [
		"A small-ish lecture hall with a projector screen over a chalkboard.",
		"There are a lot of doodles on the chalkboard... isn't this too much freedom?"
	]
	hide_choices()
	choice2.text = "Draw on the board"

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# Play video games for 1h
# Infinite choice
func _on_Choice1_pressed():
	hide_choices()
	choice1.disabled = true
	var dialog = []
	match time_until_class:
		"completed":
			continue
		"missed":
			dialog = [
				"Your professor is still here after class...",
				"You feel you've definitely made a bad impression, but at least you showed up afterwards.",
				"You ask about what you've missed.",
				"Thankfully, it seems it wasn't much."
			]
			emit_signal("queued_dialog", dialog)
			emit_signal("passed_time", 10/60)
		_:
			dialog = [
				"You wait " + str(time_until_class) + " hours for class to start.",
				"Today the professor just went over the syllabus and some basic things you already knew.",
				"The professor seems nice."
				]
			emit_signal("queued_dialog", dialog)
			emit_signal("completed_task", "Go to class")
			emit_signal("passed_time", float(time_until_class) + 1.0)
			emit_signal("lost_energy", 10) #idek
	
# Nap for 30 minutes
func _on_Choice2_pressed():
	hide_choices()
	var dialog = [
		"You add your own little doodle on the board.",
		"Nothing too conspicusus."
	]
	emit_signal("queued_dialog", dialog)
	emit_signal("passed_time", 5/60)
	
# End the day
func _on_Choice3_pressed():
	hide_choices()
	var dialog = [
		""
	]
	emit_signal("queued_dialog", dialog)
	
func _on_Daytime_time_until_class(hours):
	time_until_class = hours
	match time_until_class:
		"completed":
			pass
		"missed":
			choice1.text = "Talk to the professor"
		_:
			choice1.text = "Wait " + str(time_until_class) + " hours and go to class."
