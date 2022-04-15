extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var locations = [get_node("Library")]

# Called when the node enters the scene tree for the first time.
func _ready():
	$DialogBox.queue_dialog("Where do you want to go?")
	$Map.show()
	$PhoneMenu.disable_map_app()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# goes to a location based on a signal from the map
# queues up corresponding dialog
func _on_Map_go_to_location(location):
	$Map.hide()
	$PhoneMenu.enable_map_app()
	match location:
		"Dorm":
			pass
		"Library":
			$Library.show()
			for line in $Library.get_flavor():
				$DialogBox.queue_dialog(line)
		"DiningHall":
			pass
		"Building":
			pass

# input: float hours
# subtracts time from tasks on the phone menu
# passes time on the clock/timer
func completedAction(hours):
	$PhoneMenu.subtract_time(hours)
	$ClockContainer.passTime(hours)

func completedTask(task):
	$PhoneMenu.complete_task(task)

func increaseEnergy(percent):
	$StatsBox.increase_energy(percent)

func increaseStress(percent):
	$StatsBox.increase_stress(percent)
	
func increaseHappiness(percent):
	$StatsBox.increase_happiness(percent)

func decreaseEnergy(percent):
	$StatsBox.decrease_energy(percent)

func decreaseStress(percent):
	$StatsBox.decrease_stress(percent)
	
func decreaseHappiness(percent):
	$StatsBox.decrease_happiness(percent)

# goes back to the map from the current location
# waits for the leave text to finish before leaving
func goToMap():
	$DialogBox.clear_dialog()
	$PhoneMenu.disable_map_app()
	$DialogBox.queue_dialog("You leave the " + $Map.selected_location + ".")
	yield($DialogBox, "end_of_line")
	get_node($Map.selected_location).hide()
	$Map.show()

# shows choices after a queue of dialog ends
func showChoices():
	yield($DialogBox, "end_of_line")
	if !$Map.is_visible():
		var curr_location = $Map.selected_location
		print("current location ", curr_location)
		match curr_location:
			"Dorm":
				pass
			"Library":
				$Library.show_choices()
			"DiningHall":
				pass
			"Building":
				pass

func playChoiceDialog(dialog):
	for line in dialog:
		$DialogBox.queue_dialog(line)
