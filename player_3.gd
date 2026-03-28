extends CharacterBody2D

const speed = 150.0
const jump_velocity = -400.0 


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var current_dir = "right"

func _physics_process(delta):

	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity

	var direction = Input.get_axis("ui_left", "ui_right")
	if direction != 0:
		velocity.x = direction * speed
		current_dir = "right" if direction > 0 else "left"
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()

	play_anim(direction)

func play_anim(direction):
	var anim = $AnimatedSprite2D		

	if direction > 0:
		anim.flip_h = false
	elif direction < 0:
		anim.flip_h = true

	if not is_on_floor():
		if velocity.y < 0:
			anim.play("jumping") 
		else:
			anim.play("falling") 

	elif direction != 0:
		anim.play("walking")
	else:
		anim.play("idle")
