extends CharacterBody2D

var carSpeed = 300
@onready var game_manager = $"../gameManager"
func _ready():
	$AnimatedSprite2D.play("car")

func _physics_process(delta):
	drive(delta)
	teleport()
	carSpeed = game_manager.checkSpeed()
	
	
func drive(delta):
	velocity.x = -(carSpeed)
	
	move_and_slide()
	
func teleport():
	var random = randi_range(-200,200)
	var position = Vector2(global_position)
	if position.x < -500:
		global_position = Vector2(500, random)
	

	
	
