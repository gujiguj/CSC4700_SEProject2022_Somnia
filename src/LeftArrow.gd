extends RigidBody2D

var movement = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _physics_process(delta):
	movement.y = 150*delta
	translate(movement)


