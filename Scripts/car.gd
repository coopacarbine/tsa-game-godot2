extends CharacterBody2D

var carSpeed = -300



func _physics_process(delta):
	drive(delta)
	teleport()
	
func drive(delta):
	velocity.x = carSpeed
	
	move_and_slide()
	
func teleport():
	var random = randi_range(-200,200)
	var position = Vector2(global_position)
	if position.x < -500:
		global_position = Vector2(500, random)
	
	
	
	
