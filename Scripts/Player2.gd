extends CharacterBody2D



var yspeed = 200



#lootbox vars
var canSpinBox = true
var items = ["heart", "running_shoes", "apple", "tin_can"]


func _ready():
	$AnimatedSprite2D.play("idle")



func _physics_process(delta):
	Player_movement(delta)
	spinBox(delta)

func Player_movement(delta):
	if Input.is_action_pressed("up"):
		velocity.y = -yspeed
	elif Input.is_action_pressed("down"):
		velocity.y = yspeed
	else:
		velocity.y = 0
	move_and_slide()
	  
func spinBox(delta):
	if canSpinBox == true && Input.is_action_just_pressed( "space"):
		print("Debug(spinbox): " + items.pick_random())
		return items.pick_random()
		
	
	
