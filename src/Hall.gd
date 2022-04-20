extends "res://Location.gd"

var time_until_class = 0

onready var professor = $Background/Professor

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	npcs = [
		professor
		]
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
			professor.show()
			dialog = [
				"Your professor is still here after class...",
				"You greet her and apologize for missing class after introducing yourself.",
				"\"Oh hello! Well, it's only the first day, so don't worry about it.\"",
				"You ask about what you've missed.",
				"\"Nothing much. We just went over the syllabus and a few slides from the first chapter.\"",
				"\"I posted them online, but we'll go over them again next class.\"",
				"You thank her for your time.",
				"It seems you didn't miss much, but you feel you've made a bit of a bad impression...",
				"At least you showed up in the end."
			]
			emit_signal("queued_dialog", dialog)
			emit_signal("passed_time", 10/60)
		_:
			professor.show()
			dialog = [
				"You wait " + str(time_until_class) + " hours for class to start.",
				"Today the professor just went over the syllabus and some basic things you already knew.",
				"The professor seems nice."
				]
			emit_signal("queued_dialog", dialog)
			emit_signal("completed_task", "Go to class")
			emit_signal("passed_time", float(time_until_class) + 1.0)
			emit_signal("lost_energy", 10) #idek
	
# doodle
func _on_Choice2_pressed():
	hide_choices()
	$Background.set_texture(load("res://backgrounds/hallbg.png"))
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
