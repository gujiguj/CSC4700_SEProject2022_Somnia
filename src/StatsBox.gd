extends Control

onready var energy = $StatsBoxContainer/MarginContainer/VBoxContainer/EnergyBar
onready var stress = $StatsBoxContainer/MarginContainer/VBoxContainer/StressBar
onready var happiness = $StatsBoxContainer/MarginContainer/VBoxContainer/HappinessBar

signal energy_zero

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func increaseEnergy(var percent):
	energy.value += percent
	
func increaseStress(var percent):
	stress.value += percent
	
func increaseHappiness(var percent):
	happiness.value += percent

func decreaseEnergy(var percent):
	energy.value -= percent
	if energy.value == 0:
		emit_signal("energy_zero")

func decreaseStress(var percent):
	stress.value -= percent
	
func decreaseHappiness(var percent):
	happiness.value -= percent
	

# Called when the node enters the scene tree for the first time.
func _ready():
	energy.value = 100
	stress.value = 0
	happiness.value = 100
	$DeathMessage.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		decreaseEnergy(5)


func _on_StatsBox_energy_zero():
	$DeathMessage.show()
