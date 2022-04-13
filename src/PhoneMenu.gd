extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var phone = $PhoneContainer/PhoneHomeContainer/PhoneHomeMenu
onready var task_list = $Tasks/MarginContainer/TasksList


# Called when the node enters the scene tree for the first time.
func _ready():
	$Tasks.hide()
	#addTask(2, "Go to class")
	#addTask(1, "Do homework")
	#addTask(6, "Email professor")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(_delta):
#	pass

func _on_PhoneHomeMenu_item_selected(index):
	match(index):
		1:
			$Tasks.show()

func _on_CloseTasksButton_pressed():
	$Tasks.hide()
	
func addTask(time_left, task):
	task_list.add_item(str(time_left))
	task_list.add_item(task)
	
func subtractTime(time):
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
	for index in remove_queue:
		task_list.remove_item(index)
		
func formatTime(time):
	# converts a float value of hours to a format of H:M
	# may implement this later because this is dumb
	pass
