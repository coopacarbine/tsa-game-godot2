extends CharacterBody2D

@onready var _animated_sprite = $AnimatedSprite2D
var is_stunned: bool = false
@export var max_speed: float = 69.0 
@export var acceleration: float = 500.0
@export var friction: float = 700.0

var player: Node2D = null
var my_spawn_point: Vector2 

func _ready():
	my_spawn_point = global_position
	# Add the robot to the Enemies group automatically if you forgot in the editor
	add_to_group("Enemies")

# This is the ONLY function that should handle hitting the player
func hit_player(player_node):
	# 1. Check if the tree still exists to avoid the crash
	var tree = get_tree()
	if tree == null:
		return

	print("Robot hit the Player!")
	
	# 2. Damage the player first
	if player_node.has_method("take_damage"):
		player_node.take_damage()
	
	# 3. Use the 'tree' variable we saved to call groups
	# This prevents the "null value" error
	tree.call_group("Enemies", "stun_robot")
	tree.call_group("spawners", "spawn_at_location", my_spawn_point)
	
	# 4. Global health (if still using it)
	if has_node("/root/GameManagerLvl1"):
		GameManagerLvl1.lose_health()
	
	# 5. LAST STEP: Now it's safe to delete the robot
	queue_free()
func stun_robot():
	is_stunned = true
	velocity = Vector2.ZERO 
	_animated_sprite.play("robot_idle") 
	
	# Using a safe timer check
	var timer = get_tree().create_timer(2.0)
	if timer:
		await timer.timeout
	is_stunned = false

func _physics_process(delta):
	if is_stunned:
		velocity = Vector2.ZERO
		move_and_slide()
		return 

	var direction = Vector2.ZERO
	if player:
		direction = global_position.direction_to(player.global_position)
		# Face the player
		var target_angle = direction.angle()
		rotation = lerp_angle(rotation, target_angle, 10.0 * delta)
		
		if _animated_sprite.animation != "alert":
			_animated_sprite.play("robot_walk")
	else:
		_animated_sprite.play("robot_idle")
	
	if direction != Vector2.ZERO:
		velocity = velocity.move_toward(direction * max_speed, acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
	
	move_and_slide()
	
	# --- IMPROVED COLLISION CHECK ---
	# This checks if the robot physically bumped into the player
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		
		# Check by Name OR by Group just to be safe
		if collider.name == "Player" or collider.is_in_group("Player"):
			hit_player(collider)
			return # Exit immediately so we don't hit them twice in one frame

# --- Signal Connections ---
func _on_detection_area_body_entered(body):
	if body.name == "Player" or body.is_in_group("Player"):
		player = body 
		_animated_sprite.play("robot_walk")

func _on_detection_area_body_exited(body):
	if body.name == "Player" or body.is_in_group("Player"):
		player = null 
		_animated_sprite.play("robot_idle")

# If you have an Area2D hitbox, connect its body_entered signal here too
func _on_hitbox_body_entered(body):
	if body.name == "Player" or body.is_in_group("Player"):
		hit_player(body)
