extends Control
# god is real

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_DormButton_pressed():
	$ConfirmationDialog.window_title = "Go to dorm"
	$ConfirmationDialog.dialog_text = "Do you want to go to your dorm?"
	$ConfirmationDialog.popup_centered()

func _on_LibraryButton_pressed():
	$ConfirmationDialog.window_title = "Go to library"
	$ConfirmationDialog.dialog_text = "Do you want to go to the library?"
	$ConfirmationDialog.popup_centered()

func _on_DiningHallButton_pressed():
	$ConfirmationDialog.window_title = "Go to dining hall"
	$ConfirmationDialog.dialog_text = "Do you want to go to the dining hall?"
	$ConfirmationDialog.popup_centered()

func _on_BuildingButton_pressed():
	$ConfirmationDialog.window_title = "Go to class"
	$ConfirmationDialog.dialog_text = "Do you want to go to class?"
	$ConfirmationDialog.popup_centered()


func _on_ConfirmationDialog_confirmed():
	$MapTexture.hide()
