extends Control

onready var energy = $StatsBoxContainer/MarginContainer/VBoxContainer/EnergyBar
onready var stress = $StatsBoxContainer/MarginContainer/VBoxContainer/StressBar
onready var happiness = $StatsBoxContainer/MarginContainer/VBoxContainer/HappinessBar

signal energy_zero

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func increaseStat(var stat, var percent):
	match stat:
		"energy":
			energy.value += percent
		"stress":
			stress.value += percent
		"happiness":
			happiness.value += percent

func decreaseStat(var stat, var percent):
	match stat:
		"energy":
			energy.value -= percent
			if energy.value == 0:
				emit_signal("energy_zero")
		"stress":
			stress.value -= percent
		"happiness":
			happiness.value -= percent

func increaseEnergy(var percent):
	energy.value += percent

func decreaseEnergy(var percent):
	energy.value -= percent

func decreaseStress(var percent):
	stress.value -= percent
	
func decreaseHappiness(var percent):
	happiness.value -= percent
	

# Called when the node enters the scene tree for the first time.
func _ready():
	energy.value = 100
	stress.value = 0
	happiness.value = 100

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		decreaseStat("energy", 5)
