extends CharacterBody2D
@onready var game_manager = %gameManager


var yspeed = 200
var yloc = 0





func _ready():
	$AnimatedSprite2D.play("new_run")



func _physics_process(delta):
	Player_movement(delta)


func Player_movement(delta):
	if Input.is_action_just_released("up"):
		if(yloc > -200):
			yloc = yloc - 100
		global_position = Vector2(0, yloc)
		
	elif Input.is_action_just_pressed("down"):
		if(yloc < 200):
			yloc = yloc +100
		global_position = Vector2(0, yloc)
	
	move_and_slide()


	
