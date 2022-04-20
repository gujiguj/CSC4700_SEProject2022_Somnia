extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var task_list = $Tasks/Panel/MarginContainer/TasksList
onready var map_button = $PhoneContainer/PhoneHomeContainer/GridContainer/MapButton
onready var tasks_button = $PhoneContainer/PhoneHomeContainer/GridContainer/TasksButton

var allow_map = false

# to be used to open the map
signal leave_location 
# to be used by stats system
signal task_completed(stress) 
signal task_missed(stress)

# Called when the node enters the scene tree for the first time.
func _ready():
	disable_map_app()
	enable_phone_menu()
	$Tasks.hide()
	$ConfirmationDialog.hide()
	# addTask(2, "Go to class")
	# addTask(2, "Do homework")
	# addTask(2, "Email professor")

# Called every frame. 'delta' is the elapsed time since the previous frame.
# func _process(_delta):
	#pass
	# if Input.is_action_just_pressed("ui_accept"):
	# 	subtractTime(0.25)

# when map app is clicked
# asks if the player wants to leave with a confirmation dialog 
func _on_MapButton_pressed():
	$ConfirmationDialog.popup()
	disable_phone_menu()

# when tasks app is clicked
# opens tasks menu 
func _on_TasksButton_pressed():
	print("here are your tasks")
	$Tasks.show()
	disable_phone_menu()

# disables all items on the phone menu
func disable_phone_menu():
	map_button.disabled = true
	tasks_button.disabled = true

# disables mapp app access
func disable_map_app():
	allow_map = false
	map_button.disabled = true

# enables all items on the phone menu
# if map button isn't allowed, only enable tasks
func enable_phone_menu():
	if allow_map:
		map_button.disabled = false
		tasks_button.disabled = false
	else:
		map_button.disabled = true
		tasks_button.disabled = false

# enables map app access
func enable_map_app():
	allow_map = true
	map_button.disabled = false
	
# closes tasks menu if the close button is pressed
func _on_CloseTasksButton_pressed():
	$Tasks.hide()
	enable_phone_menu()

# input: float, string
# adds a task description and how much time it has left in hours	
func add_task(time_left, task):
	task_list.add_item(str(time_left))
	task_list.add_item(task)
	
# returns the time left on a given task
func get_time_left(task):
	for index in task_list.get_item_count():
		if task_list.get_item_text(index) == task:
			print("getting time left on: " + task_list.get_item_text(index))
			return float(task_list.get_item_text(index-1))
	return 0.0

# input: string
# searches for the corresponding task by the string and removes it	
# emits a signal to be used by the stats system
# THIS MUST BE CALLED BEFORE subtract_time!!!!
func complete_task(task):
	for index in task_list.get_item_count():
		if task_list.get_item_text(index) == task:
			task_list.set_item_text(index-1, "completed")
			emit_signal("task_completed", 15)
#	var remove_queue = []
#	for index in task_list.get_item_count():
#		if task_list.get_item_text(index) == task:
#			remove_queue.push_front(index-1)
#			remove_queue.push_front(index)
#			break
#	if remove_queue.empty() == false:
#		for index in remove_queue:
#			emit_signal("task_completed", 15)
#			task_list.remove_item(index)
	
# input: float
# subtracts time from each of the tasks
# emits a signal if any task runs out of time to be used by stats system
func subtract_time(time):
	var remove_queue = []
	for index in task_list.get_item_count():
		if index % 2 == 0:
			if task_list.get_item_text(index) != "completed" && task_list.get_item_text(index) != "missed":
				print("Subtracting ", time, " hours from ", index)
				var text = float(task_list.get_item_text(index))
				print("Current time left: ", str(text))
				text -= time
				task_list.set_item_text(index, str(text)) 
				print("New time left: ", task_list.get_item_text(index))
				if text <= 0:
					task_list.set_item_text(index, "missed")
					emit_signal("task_missed", 15)
#					remove_queue.push_front(index)
#					remove_queue.push_front(index+1)
#	if remove_queue.empty() == false:
#		for index in remove_queue:
#			task_list.remove_item(index)
#			emit_signal("task_missed", 15) # to be used by stats system
		
# func formatTime(time):
	# converts a float value of hours to a format of H:M
	# may implement this later because this is dumb
	# pass

func _on_ConfirmationDialog_popup_hide():
	enable_phone_menu()

func _on_ConfirmationDialog_confirmed():
	emit_signal("leave_location") # to be used to open the map




