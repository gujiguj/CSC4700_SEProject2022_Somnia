extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var Daytime = get_node("/root/Daytime")

# Called when the node enters the scene tree for the first time.
func _ready():
	Daytime.hide()
#	OS.set_window_size(Vector2(1080,681))
#	print("SET WINDOW SIZE FOR TUTORIAL")
	#OS.window_size = Vector2(1080*.676,681*0.75)
	$TutorialSong.play()
	$HP.text = "Health: " + str($Player.player_health)
	

#362 between each measure in the song
#90.5 between each beat
#181 between every 2 beats
#271.5 between every 3 beats


func _on_TutorialSong_finished():
#	OS.set_window_size(Vector2(1200,800))
#	print("SET WINDOW SIZE FOR DAYTIME")
	#OS.window_size = (Vector2(1200,800))
	get_tree().change_scene("res://Daytime.tscn")
	#Daytime.calc_energy_from_night($Player.player_health)


func _on_Player_hit():
	$HP.text = "Health: " + str($Player.player_health)
	
func get_player_health():
	return $Player.player_health
