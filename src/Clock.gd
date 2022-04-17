extends MarginContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var clock = $MarginContainer/ClockText

# signal emitted when the clock is 0
signal day_over

# Called when the node enters the scene tree for the first time.
func _ready():
	clock.text = "8"
	clock.visible_characters = 4
	clock.ALIGN_CENTER

# Called every frame. 'delta' is the elapsed time since the previous frame.
# func _process(delta):
#	if Input.is_action_just_pressed("ui_accept"):
#		passTime(0.5)
#	pass

# input: float representing hours passed
# used to decrease time on the clock 
# emits day over signal if time is less than or equal to 0
func pass_time(hours):
	var curr_time = float(clock.text)
	var new_time = curr_time - hours
	clock.text = str(new_time)
	if new_time <= 0:
		emit_signal("day_over")
	
func end_day():
	pass_time(float(clock.text))

func format_time():
	pass
