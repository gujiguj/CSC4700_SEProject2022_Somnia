extends Control

# Declare member variables here. 
onready var choices = $Background/ChoicesContainer
onready var choice1 = $Background/ChoicesContainer/VBoxContainer/Choice1
onready var choice2 = $Background/ChoicesContainer/VBoxContainer/Choice2
onready var choice3 = $Background/ChoicesContainer/VBoxContainer/Choice3
onready var choice_leave = $Background/ChoicesContainer/VBoxContainer/Leave

# flavor text dialog array to be queued
onready var flavor = []

# to be used to open up the map
signal leave_location

signal passed_time(hours) # float hours; used to pass time
signal completed_task(task) # string task; used to complete a task

# string dialog
# used to signal that choice dialog has been queued
signal queued_dialog(dialog)

# int percent; gain/lose various stats
signal gained_energy(percent) 
signal gained_stress(percent) 
signal gained_happiness(percent)
signal lost_energy(percent)
signal lost_stress(percent)
signal lost_happiness(percent)

# Called when the node enters the scene tree for the first time.
func _ready():
	choices.hide()
	$Background/ConfirmationDialog.hide()
	choice1.text = ""
	choice2.text = ""
	choice3.text = ""
	choice_leave = "Leave"

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Choice1_pressed():
	choice1.disabled = true
	# include task functions if applicable

func _on_Choice2_pressed():
	choice2.disabled = true
	# include task functions if applicable

func _on_Choice3_pressed():
	choice3.disabled = true
	# include task functions if applicable
	
# opens a confirmation dialog asking if player wants to leave
func _on_Leave_pressed():
	$Background/ConfirmationDialog.popup()

# emits a signal to open up the map when the player confirms they want to leave
func _on_ConfirmationDialog_confirmed():
	choices.hide()
	emit_signal("leave_location")
	
func hide_choices():
	choices.hide()

func show_choices():
	choices.show()
	
# returns the flavor text
func get_flavor():
	return flavor
