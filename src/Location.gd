extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var choices = $LocationBg/MarginContainer/ChoicesContainer
onready var choice1 = $LocationBg/MarginContainer/ChoicesContainer/Choice1
onready var choice2 = $LocationBg/MarginContainer/ChoicesContainer/Choice2
onready var choice3 = $LocationBg/MarginContainer/ChoicesContainer/Choice3
onready var choice_leave = $LocationBg/MarginContainer/ChoicesContainer/Leave

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
