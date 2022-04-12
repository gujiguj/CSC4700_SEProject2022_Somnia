extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var choices = $LocationBg/ChoicesContainer
onready var choice1 = $LocationBg/ChoicesContainer/VBoxContainer/Choice1
onready var choice2 = $LocationBg/ChoicesContainer/VBoxContainer/Choice2
onready var choice3 = $LocationBg/ChoicesContainer/VBoxContainer/Choice3
onready var choice_leave = $LocationBg/ChoicesContainer/VBoxContainer/Leave

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Choice1_pressed():
	choice1.disabled = true

func _on_Choice2_pressed():
	choice2.disabled = true

func _on_Choice3_pressed():
	choice3.disabled = true
	
func _on_Leave_pressed():
	$LocationBg/ConfirmationDialog.popup()

func _on_ConfirmationDialog_confirmed():
	choices.hide()
