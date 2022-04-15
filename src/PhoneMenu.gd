extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var phone = $PhoneContainer/PhoneHomeContainer/PhoneHomeMenu
onready var task_list = $Tasks/Panel/MarginContainer/TasksList

var allow_map = false

# to be used to open the map
signal leave_location 
# to be used by stats system
signal task_completed 
signal task_missed

# Called when the node enters the scene tree for the first time.
func _ready():
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

# asks if the player wants to leave with a confirmation dialog if the map icon is selected
# opens tasks menu if the icon on the phone menu is selected
func _on_PhoneHomeMenu_item_selected(index):
	match(index):
		0:
			$ConfirmationDialog.popup()
		1:
			print("here are your tasks")
			$Tasks.show()
	disable_phone_menu()

# disables all items on the phone menu
func disable_phone_menu():
	for index in phone.get_item_count():
		phone.set_item_disabled(index, true)
		
func disable_map_app():
	allow_map = false
	phone.set_item_disabled(0, true)

# enbales all items on the phone menu
func enable_phone_menu():
	if allow_map:
		for index in phone.get_item_count():
			phone.set_item_disabled(index, false)
	else:
		phone.set_item_disabled(1, false)

func enable_map_app():
	allow_map = true
	phone.set_item_disabled(0, false)
	
# closes tasks menu if the close button is pressed
func _on_CloseTasksButton_pressed():
	$Tasks.hide()
	enable_phone_menu()

# input: float, string
# adds a task description and how much time it has left in hours	
func add_task(time_left, task):
	task_list.add_item(str(time_left))
	task_list.add_item(task)

# input: string
# searches for the corresponding task by the string and removes it	
# emits a signal to be used by the stats system
# THIS MUST BE CALLED BEFORE subtractTime!!!!
func complete_task(task):
	var remove_queue = []
	for index in task_list.get_item_count():
		if task_list.get_item_text(index) == task:
			remove_queue.push_front(index-1)
			remove_queue.push_front(index)
			break
	if remove_queue.empty() == false:
		for index in remove_queue:
			emit_signal("task_completed")
			task_list.remove_item(index)
	
# input: float
# subtracts time from each of the tasks
# emits a signal if any task runs out of time to be used by stats system
func subtract_time(time):
	var remove_queue = []
	for index in task_list.get_item_count():
		if index % 2 == 0:
			print("Subtracting ", time, " hours from ", index)
			var text = float(task_list.get_item_text(index))
			print("Current time left: ", str(text))
			text -= time
			task_list.set_item_text(index, str(text)) 
			print("New time left: ", task_list.get_item_text(index))
			if text <= 0:
				remove_queue.push_front(index)
				remove_queue.push_front(index+1)
	if remove_queue.empty() == false:
		for index in remove_queue:
			task_list.remove_item(index)
			emit_signal("task_missed") # to be used by stats system
		
# func formatTime(time):
	# converts a float value of hours to a format of H:M
	# may implement this later because this is dumb
	# pass

func _on_ConfirmationDialog_popup_hide():
	enable_phone_menu()

func _on_ConfirmationDialog_confirmed():
	emit_signal("leave_location") # to be used to open the map
