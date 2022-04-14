extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var library_bg = preload("res://images/librarybg.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	$Library/Background.texture = library_bg


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Map_go_to_location(location):
	$Map.hide()
	match location:
		"dorm":
			pass
		"library":
			$Library.show()
		"dining hall":
			pass
		"building":
			pass
