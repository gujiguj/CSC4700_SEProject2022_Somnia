extends CanvasLayer

# no I do not know what this means exactly
# smaller number is faster apparently.
const CHAR_READ_RATE = 0.05
const START_TEXT = "*"
var END_TEXT = ">"

onready var dialog_container = $DialogBoxContainer
onready var start_symbol = $DialogBoxContainer/MarginContainer/HBoxContainer/StartSymbol
onready var end_symbol = $DialogBoxContainer/MarginContainer/HBoxContainer/EndSymbol
onready var dialog = $DialogBoxContainer/MarginContainer/HBoxContainer/Text

# different states the box can be in
enum State {
	READY,
	READING,
	FINISHED
}

var current_state = State.READY
var dialog_queue = [] # queue for displaying texts
	
# Called when the node enters the scene tree for the first time.
func _ready():
	print("Starting state: State.READY")
	show_dialogbox()
	
	# queue up a bunch of dialog
	queue_dialog("Example text 1.")
	queue_dialog("Example text 2.")
	queue_dialog("Example text 3.")
	queue_dialog("Example text 4.")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	match current_state:
		# display dialog if the dialog queue is not empty
		State.READY:
			if !dialog_queue.empty():
				display_dialog()
		# if currently reading, enter key can be pressed to skip the tweening and go to the finished state.
		State.READING:
			if Input.is_action_just_pressed("ui_accept"):
				dialog.percent_visible = 1.0
				$Tween.remove_all()
				end_symbol.text = END_TEXT
				change_state(State.FINISHED)
		# if done reading, enter key can be pressed to bring the box back to the ready state
		State.FINISHED:
			if Input.is_action_just_pressed("ui_accept"):
				change_state(State.READY)
				hide_dialogbox()

# queue up dialog
func queue_dialog(next_text):
	dialog_queue.push_back(next_text)

# shows the dialog box with just the start symbol
func show_dialogbox():
	start_symbol.text = START_TEXT
	dialog_container.show()

# hide the dialog box and clear all text
func hide_dialogbox():
	start_symbol.text = ""
	end_symbol.text = ""
	dialog.text = ""
	dialog_container.hide()

# displays text received from the front of the dialog queue
func display_dialog():
	dialog.percent_visible = 0.0
	# gets the text at the front of the queue
	var next_text = dialog_queue.pop_front()
	dialog.text = next_text
	change_state(State.READING)
	show_dialogbox()
	# Tweens the text animation so it doesn't show up all at once.
	# Manipulates the rate the text shows up based on a fixed rate and the text character length
	# & some generic Tween properties
	$Tween.interpolate_property(dialog, "percent_visible", 0.0, 1.0, len(next_text)*CHAR_READ_RATE, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()

# when text is done animating, change state to finished
func _on_Tween_tween_completed():
	end_symbol.text = END_TEXT
	change_state(State.FINISHED)
	
# changes the current state of the box
# match function that prints the current state after changing for tracking purposes
func change_state(next_state):
	current_state = next_state
	match current_state:
		State.READY:
			print("Changing state to: State.READY")
		State.READING:
			print("Changing state to: State.READING")
		State.FINISHED:
			print("Changing state to: State.FINISHED")
			


