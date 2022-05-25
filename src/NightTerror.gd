extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	OS.set_window_size(Vector2(730,500))
	$TutorialSong.play()
	$Heartbeat.play()
	$HP.text = "Health: " + str($Player.player_health)
	

#362 between each measure in the song
#90.5 between each beat
#181 between every 2 beats
#271.5 between every 3 beats


func _on_TutorialSong_finished():
	get_tree().quit()


func _on_Player_hit():
	$HP.text = "Health: " + str($Player.player_health)
