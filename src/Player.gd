extends Area2D

signal hit
export var player_speed = 400
export var player_health = 100
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	print("Start")
	print("Player Health: ", player_health)
	#hide()
	
func _process(delta):
	#Variable to change player movement
	var movement = Vector2.ZERO
	
	if Input.is_action_pressed("move_right"):
		movement.x += 1
	if Input.is_action_pressed("move_left"):
		movement.x -= 1
	if Input.is_action_pressed("move_down"):
		movement.y += 1
	if Input.is_action_pressed("move_up"):
		movement.y -= 1

	if movement.length() > 0:
		movement = movement.normalized() * player_speed
		
	position += movement * delta
	position.x = clamp(position.x, 25, screen_size.x-25)
	position.y = clamp(position.y, 25, screen_size.y-20)
	
func _on_Player_body_entered(body):
	$HitSound.play()
	print("Hit")
	#Player Loses 10hp per hit
	if player_health != 0:
		player_health -= 10
		print("New Player Health = ", player_health)
	
	if player_health <= 0:
		print("No HP :(")
	emit_signal("hit")
	
	#Player gains temporary invincibility
	for n in range(5):
		$CollisionShape2D.set_deferred("disabled", true)
		$CollisionShape2D2.set_deferred("disabled", true)
	$CollisionShape2D.set_deferred("disabled", false)
	$CollisionShape2D2.set_deferred("disabled", false)
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
