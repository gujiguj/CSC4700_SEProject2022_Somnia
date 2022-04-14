extends Control

# Declare member variables here. 
onready var choices = $LocationBg/ChoicesContainer
onready var choice1 = $LocationBg/ChoicesContainer/VBoxContainer/Choice1
onready var choice2 = $LocationBg/ChoicesContainer/VBoxContainer/Choice2
onready var choice3 = $LocationBg/ChoicesContainer/VBoxContainer/Choice3
onready var choice_leave = $LocationBg/ChoicesContainer/VBoxContainer/Leave

# to be used to open up the map
signal leave_location

# Called when the node enters the scene tree for the first time.
func _ready():
	$LocationBg/ConfirmationDialog.hide()
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
	$LocationBg/ConfirmationDialog.popup()

# emits a signal to open up the map when the player confirms they want to leave
func _on_ConfirmationDialog_confirmed():
	choices.hide()
	emit_signal("leave_location")
