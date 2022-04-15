extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var locations = [get_node("Library")]

# Called when the node enters the scene tree for the first time.
func _ready():
	$DialogBox.queue_dialog("Where do you want to go?")
	$Map.show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# goes to a location based on a signal from the map
# queues up corresponding dialog
func _on_Map_go_to_location(location):
	$Map.hide()
	match location:
		"Dorm":
			pass
		"Library":
			$Library.show()
			for line in $Library.getDialog():
				$DialogBox.queue_dialog(line)
		"DiningHall":
			pass
		"Building":
			pass

# input: float hours
# subtracts time from tasks on the phone menu
# passes time on the clock/timer
func completedAction(hours):
	$PhoneMenu.subtractTime(hours)
	$ClockContainer.passTime(hours)

func completedTask(task):
	$PhoneMenu.completeTask(task)

func increaseEnergy(percent):
	$StatsBox.increaseEnergy(percent)

func increaseStress(percent):
	$StatsBox.increaseStress(percent)
	
func increaseHappiness(percent):
	$StatsBox.increaseHappiness(percent)

func decreaseEnergy(percent):
	$StatsBox.decreaseEnergy(percent)

func decreaseStress(percent):
	$StatsBox.decreaseStress(percent)
	
func decreaseHappiness(percent):
	$StatsBox.decreaseHappiness(percent)


func goToMap():
	$DialogBox.queue_dialog("You leave the " + $Map.selected_location + ".")
	yield($DialogBox, "end_of_line")
	get_node($Map.selected_location).hide()
	$Map.show()

func showChoices():
	yield($DialogBox, "end_of_line")
	if !$Map.is_visible():
		var curr_location = $Map.selected_location
		print("current location ", curr_location)
		match curr_location:
			"Dorm":
				pass
			"Library":
				$Library.showChoices()
			"DiningHall":
				pass
			"Building":
				pass

func playChoiceDialog(dialog):
	for line in dialog:
		$DialogBox.queue_dialog(line)
