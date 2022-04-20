extends Control

# uncomment this when tutorial is added as a global node
# var tutorial = get_node(/root/Tutorial)
# var accuracy = tutorial.accuracy

# list of location nodes
onready var locations = [
	get_node("Dorm"), 
	get_node("Library"), 
	get_node("DiningHall"), 
	get_node("Hall")
	]
# distance matrix of the time and energy cost to travel b/t locations
# 0 = Dorm, 1 = Library, 2 = DiningHall, 3 = Hall
# Should be a symmetric matrix.
var distances = [
	[0, 5, 15, 10],
	[5, 0, 10, 10],
	[15, 10, 0, 5],
	[10, 10, 5, 0]
]
# input: strings for the current location and destination
# returns the distance between the two
func get_distance(from, to):
	var i = 0
	var j = 0
	for place in locations:
		if place.get_name() == from:
			break
		i += 1
	for place in locations:
		if place.get_name() == to:
			break
		j += 1
	return distances[i][j]

# keeps track of current location
var curr_location = "Dorm"
# keeps track of whether the day is over, honestly I'm not sure what for
var day_over = false

# for Hall
signal time_until_class(hours)

# Called when the node enters the scene tree for the first time.
func _ready():
	# implement energy function for stats
	# $StatsBox.calc_energy_from_night(accuracy)
	$PhoneMenu.add_task(8.0, "Homework")
	$PhoneMenu.add_task(4.0, "Go to class")
	$PhoneMenu.disable_map_app()
	hide_places()
	$DialogBox.queue_dialog("Where do you want to go?")
	$Map.show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# clears the interface of all locations
func hide_places():
	for place in locations:
		place.hide()

# input: string dest_name, name of destination
# goes to a location based on a signal from the map
# subtracts time and energy based on current location and destination
# queues up corresponding dialog
func _on_Map_go_to_location(dest_name):
	$Map.hide()
	$PhoneMenu.disable_phone_menu()
	var destination = get_node(dest_name)
	print("Going to ", dest_name, " from ", curr_location)
	var distance = get_distance(curr_location, dest_name)
	destination.show()
	destination.hide_choices()
	$DialogBox.queue_dialog_list(destination.get_flavor())
	$StatsBox.decrease_energy(distance)
	$ClockContainer.pass_time(distance/60.0)
	# need to update one of the hall's choices with this--may need to re-implement this better
	if dest_name == "Hall":
		emit_signal("time_until_class", $PhoneMenu.get_time_left("Go to class"))
	curr_location = dest_name

# goes back to the map from the current location
# waits for the leave text to finish before leaving
func go_to_map():
	$DialogBox.clear_dialog()
	$PhoneMenu.disable_map_app()
	$PhoneMenu.disable_phone_menu()
	$DialogBox.queue_dialog("You leave the " + curr_location + ".")
	yield($DialogBox, "end_of_line")
	hide_places()
	$Map.show()

# shows choices after a queue of dialog ends
func show_choices():
	if !day_over and !$Map.is_visible():
		yield($DialogBox, "end_of_line")
		$PhoneMenu.enable_map_app()
		$PhoneMenu.enable_phone_menu()
		get_node(curr_location).show_choices()
		get_node(curr_location).hide_npcs()

func _on_ClockContainer_day_over():
	day_over = true
	$DialogBox.clear_dialog()
	$DialogBox.queue_dialog("It's getting late. You start getting ready for bed.")
	end_day()

func _on_StatsBox_energy_zero():
	day_over = true
	$DialogBox.clear_dialog()
	$DialogBox.queue_dialog("You feel pooped. Let's go back to your dorm.")
	end_day()
	
func end_day():
	yield($DialogBox, "end_of_line")
	$Map.hide()
	hide_places()
	$Dorm.hide_choices()
	$Dorm.show()
	$PhoneMenu.disable_phone_menu()
	$DialogBox.queue_dialog("That's all folks! It's time for bed now.")

# used for nighttime
func get_stats():
	var stats = [
		$StatsBox.energy,
		$StatsBox.stress,
		$StatsBox.happiness
	]
	return stats
	
