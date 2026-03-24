extends CharacterBody2D
@onready var game_manager = $"../../gameManager"


var yspeed = 200





func _ready():
	$AnimatedSprite2D.play("runner")



func _physics_process(delta):
	Player_movement(delta)


func Player_movement(delta):
	if Input.is_action_pressed("up"):
		velocity.y = -yspeed
	elif Input.is_action_pressed("down"):
		velocity.y = yspeed
	else:
		velocity.y = 0
	move_and_slide()


	
