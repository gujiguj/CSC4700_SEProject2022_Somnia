extends "res://Location.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	flavor = [
		"Classroom."
	]
	hide_choices()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# Play video games for 1h
# Infinite choice
func _on_Choice1_pressed():
	hide_choices()
	var dialog = [
		""
	]
	emit_signal("queued_dialog", dialog)
	choice1.disabled = true
	
# Nap for 30 minutes
func _on_Choice2_pressed():
	hide_choices()
	var dialog = [
		""
	]
	emit_signal("queued_dialog", dialog)
	
# End the day
func _on_Choice3_pressed():
	hide_choices()
	var dialog = [
		""
	]
	emit_signal("queued_dialog", dialog)
