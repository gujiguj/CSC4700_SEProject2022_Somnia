extends Control
# god is real

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var dorm = $MapTexture/DormButton
onready var library = $MapTexture/LibraryButton
onready var dining_hall = $MapTexture/DiningHallButton
onready var building = $MapTexture/BuildingButton

var selected_location = ""

signal go_to_location(location)

# Called when the node enters the scene tree for the first time.
func _ready():
	enableButtons()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# disables all location buttons
func disableButtons():
	dorm.disabled = true
	library.disabled = true
	dining_hall.disabled = true
	building.disabled = true
	
# enables all location buttons
func enableButtons():
	dorm.disabled = false
	library.disabled = false
	dining_hall.disabled = false
	building.disabled = false

func _on_DormButton_pressed():
	selected_location = "dorm"
	$ConfirmationDialog.window_title = "Go to dorm"
	$ConfirmationDialog.dialog_text = "Do you want to go to your dorm?"
	$ConfirmationDialog.popup_centered()

func _on_LibraryButton_pressed():
	selected_location = "library"
	$ConfirmationDialog.window_title = "Go to library"
	$ConfirmationDialog.dialog_text = "Do you want to go to the library?"
	$ConfirmationDialog.popup_centered()

func _on_DiningHallButton_pressed():
	selected_location = "dining hall"
	$ConfirmationDialog.window_title = "Go to dining hall"
	$ConfirmationDialog.dialog_text = "Do you want to go to the dining hall?"
	$ConfirmationDialog.popup_centered()

func _on_BuildingButton_pressed():
	selected_location = "building"
	$ConfirmationDialog.window_title = "Go to class"
	$ConfirmationDialog.dialog_text = "Do you want to go to class?"
	$ConfirmationDialog.popup_centered()

func _on_ConfirmationDialog_confirmed():
	$MapTexture.hide()
	emit_signal("go_to_location", selected_location)
	print("went to ", selected_location)
