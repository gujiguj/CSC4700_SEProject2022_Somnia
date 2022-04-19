extends "res://Location.gd"

var time_until_class = 0

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	flavor = [
		"Classroom."
	]
	hide_choices()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# Play video games for 1h
# Infinite choice
func _on_Choice1_pressed():
	hide_choices()
	choice1.disabled = true
	var dialog = [
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
		""
	]
	emit_signal("queued_dialog", dialog)
	
# End the day
func _on_Choice3_pressed():
	hide_choices()
	var dialog = [
		""
	]
	emit_signal("queued_dialog", dialog)
	
func _on_Daytime_time_until_class(hours):
	time_until_class = hours
	if time_until_class <= 0:
		choice1.text = "Go to class late"
	else:
		choice1.text = "Wait " + str(time_until_class) + " hours and go to class."
