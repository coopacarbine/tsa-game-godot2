extends CharacterBody2D

const speed = 70
var current_dir = "none"

@onready var vision_sprite: Sprite2D = %VisionSprite

func _ready():
	$AnimatedSprite2D.play("ch1_idle_down")


func _physics_process(delta):
	player_movement(delta)
	
func player_movement(delta):
	
	if Input.is_action_pressed("ui_right"):
		current_dir = "right"
		play_anim(1)
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_left"):
		current_dir = "left"
		play_anim(1)
		velocity.x = -speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_down"):
		current_dir = "down"
		play_anim(1)
		velocity.y = speed
		velocity.x = 0
	elif Input.is_action_pressed("ui_up"):
		current_dir = "up"
		play_anim(1)
		velocity.y = -speed
		velocity.x = 0
	else:
		play_anim(0)
		velocity.y = 0
		velocity.x = 0
		
	move_and_slide()
	
		
func play_anim(movement):
	var anim = $AnimatedSprite2D		
	
	if current_dir == "right":
		anim.flip_h = false
		if movement == 1:
			anim.play("ch1_run_right")
		else:
			anim.play("ch1_idle_right")
			
	elif current_dir == "left":
		anim.flip_h = true 
		if movement == 1: 
			anim.play("ch1_run_right") 
		else:
			anim.play("ch1_idle_right")
	
			
	elif current_dir == "up":
		anim.flip_h = true 
		if movement == 1: 
			anim.play("ch1_run_up") 
		else:
			anim.play("ch1_idle_up")
			
	elif current_dir == "down":
		anim.flip_h = false 
		if movement == 1: 
			anim.play("ch1_run_down") 
		else:
			anim.play("ch1_idle_down")
			
			
