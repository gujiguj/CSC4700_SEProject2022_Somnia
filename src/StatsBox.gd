extends Control

onready var energy = $StatsBoxContainer/MarginContainer/VBoxContainer/EnergyBar
onready var stress = $StatsBoxContainer/MarginContainer/VBoxContainer/StressBar
onready var happiness = $StatsBoxContainer/MarginContainer/VBoxContainer/HappinessBar

# signal emitted when energy is zero, ending the day
signal energy_zero

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func increaseEnergy(percent):
	energy.value += percent
	
func increaseStress(percent):
	stress.value += percent
	
func increaseHappiness(percent):
	happiness.value += percent

func decreaseEnergy(percent):
	energy.value -= percent
	if energy.value <= 0:
		emit_signal("energy_zero")

func decreaseStress(percent):
	stress.value -= percent
	
func decreaseHappiness(percent):
	happiness.value -= percent
	
# Called when the node enters the scene tree for the first time.
func _ready():
	energy.value = 100
	stress.value = 0
	happiness.value = 100

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(_delta):
#	if Input.is_action_just_pressed("ui_accept"):
#		decreaseEnergy(5)
