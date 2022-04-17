extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# list of location nodes
# ADD HALL!!
onready var locations = [get_node("Dorm"), get_node("Library"), get_node("DiningHall")]

# distance matrix of the time and energy cost to travel b/t locations
# 0 = Dorm, 1 = Library, 2 = DiningHall, 3 = Hall
# Should be a symmetric matrix.
var distances = [
	[0, 5, 15, 10],
	[5, 0, 10, 10],
	[15, 10, 0, 5],
	[10, 10, 5, 0]
]

# keeps track of current location
var curr_location = "Dorm"

# Called when the node enters the scene tree for the first time.
func _ready():
	for place in locations:
		place.hide()
	$PhoneMenu.disable_map_app()
	$DialogBox.queue_dialog("Where do you want to go?")
	$Map.show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# goes to a location based on a signal from the map
# queues up corresponding dialog
func _on_Map_go_to_location(location):
	$Map.hide()
	$PhoneMenu.disable_phone_menu()
	var selected_location = get_node(location)
	print("Going to ", location, " from ", curr_location)
	var i = 0
	var j = 0
	for place in locations:
		if place.get_name() == curr_location:
			break
		i += 1
	for place in locations:
		if place.get_name() == location:
			break
		j += 1
	decrease_energy(distances[i][j])
	pass_time(distances[i][j]/60.0)
	selected_location.show()
	selected_location.hide_choices()
	for line in selected_location.get_flavor():
		$DialogBox.queue_dialog(line)
	curr_location = location

# input: float hours
# subtracts time from tasks on the phone menu
# passes time on the clock/timer
func pass_time(hours):
	print("passed ", hours, " hrs")
	$PhoneMenu.subtract_time(hours)
	$ClockContainer.pass_time(hours)

func complete_task(task):
	$PhoneMenu.complete_task(task)

func increase_energy(percent):
	$StatsBox.increase_energy(percent)

func increase_stress(percent):
	$StatsBox.increase_stress(percent)
	
func increase_happiness(percent):
	$StatsBox.increase_happiness(percent)

func decrease_energy(percent):
	$StatsBox.decrease_energy(percent)

func decrease_stress(percent):
	$StatsBox.decrease_stress(percent)
	
func decrease_happiness(percent):
	$StatsBox.decrease_happiness(percent)

# goes back to the map from the current location
# waits for the leave text to finish before leaving
func go_to_map():
	$DialogBox.clear_dialog()
	$PhoneMenu.disable_map_app()
	$PhoneMenu.disable_phone_menu()
	$DialogBox.queue_dialog("You leave the " + $Map.selected_location + ".")
	yield($DialogBox, "end_of_line")
	for place in locations:
		place.hide()
	$Map.show()

# shows choices after a queue of dialog ends
func show_choices():
	if !$Map.is_visible():
		yield($DialogBox, "end_of_line")
		$PhoneMenu.enable_map_app()
		$PhoneMenu.enable_phone_menu()
		get_node($Map.selected_location).show_choices()
		#match curr_location:
		#	"Dorm":
		#		$Dorm.show_choices()
		#	"Library":
		#		$Library.show_choices()
		#	"DiningHall":
		#		pass
		#	"Building":
		#		pass

func play_choice_dialog(dialog):
	for line in dialog:
		$DialogBox.queue_dialog(line)

func _on_Dorm_end_day():
	$ClockContainer.end_day()

func _on_ClockContainer_day_over():
	$DialogBox.clear_dialog()
	$DialogBox.queue_dialog("That's all folks! It's time for bed now.")
