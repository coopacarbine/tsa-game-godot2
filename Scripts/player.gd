extends CharacterBody2D

const speed = 70
var current_dir = "none"

@onready var vision_sprite: Sprite2D = %VisionSprite
@onready var anim = $AnimatedSprite2D 
# ADD THIS: Make sure you have an AudioStreamPlayer2D named FootstepSound on the player
@onready var footstep_sound = $FootstepSound 

var is_stunned: bool = false
var hearts = 3
var can_take_damage = true 
@onready var hurt_sound = $HurtSound
@onready var death_sound = $DeathSound

func _ready():
	$AnimatedSprite2D.play("ch1_idle_down")
	# Optional: random pitch makes footsteps sound more natural
	if footstep_sound:
		footstep_sound.bus = "SFX" 

func _physics_process(delta):
	if is_stunned:
		velocity = Vector2.ZERO 
		# Stop footsteps if we get stunned
		if footstep_sound and footstep_sound.playing:
			footstep_sound.stop()
		move_and_slide()
		return 
		
	player_movement(delta)

func player_movement(delta):
	footstep_sound.pitch_scale = randf_range(0.9, 1.1)
	var moving = false
	
	if Input.is_action_pressed("ui_right"):
		current_dir = "right"
		moving = true
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_left"):
		current_dir = "left"
		moving = true
		velocity.x = -speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_down"):
		current_dir = "down"
		moving = true
		velocity.y = speed
		velocity.x = 0
	elif Input.is_action_pressed("ui_up"):
		current_dir = "up"
		moving = true
		velocity.y = -speed
		velocity.x = 0
	else:
		moving = false
		velocity.y = 0
		velocity.x = 0
	
	# Call play_anim with 1 if moving, 0 if idle
	play_anim(1 if moving else 0)
	move_and_slide()

func play_anim(movement):
	var anim_node = $AnimatedSprite2D		
	
	# FOOTSTEP LOGIC
	if footstep_sound:
		if movement == 1:
			if not footstep_sound.playing:
				footstep_sound.play()
		else:
			footstep_sound.stop()

	if current_dir == "right":
		anim_node.flip_h = false
		if movement == 1:
			anim_node.play("ch1_run_right")
		else:
			anim_node.play("ch1_idle_right")
			
	elif current_dir == "left":
		anim_node.flip_h = true 
		if movement == 1: 
			anim_node.play("ch1_run_right") 
		else:
			anim_node.play("ch1_idle_right")
			
	elif current_dir == "up":
		anim_node.flip_h = true 
		if movement == 1: 
			anim_node.play("ch1_run_up") 
		else:
			anim_node.play("ch1_idle_up")
			
	elif current_dir == "down":
		anim_node.flip_h = false 
		if movement == 1: 
			anim_node.play("ch1_run_down") 
		else:
			anim_node.play("ch1_idle_down")

# ... rest of your damage/death functions stay exactly the same ...
func take_damage():
	if not can_take_damage: return 
	can_take_damage = false 
	GameManagerLvl1.lose_health()
	hearts = GameManagerLvl1.health
	if hearts <= 0:
		is_stunned = true 
		velocity = Vector2.ZERO
		$AnimatedSprite2D.play("ch1_idle_down")
		modulate = Color(0.5, 0.5, 0.5, modulate.a) 
		handle_death_sequence() 
	else:
		if hurt_sound: hurt_sound.play()
		start_stun()
		start_invincibility()

func handle_death_sequence():
	if death_sound: death_sound.play()
	await get_tree().create_timer(1.2).timeout 
	die()

func start_invincibility():
	modulate.a = 0.5 
	await get_tree().create_timer(1.0).timeout
	can_take_damage = true
	if not is_stunned: modulate.a = 1.0

func start_stun():
	if is_stunned: return 
	is_stunned = true
	$AnimatedSprite2D.play("ch1_idle_down")
	modulate = Color(0.5, 0.5, 0.5, modulate.a) 
	%StunTimer.start(2.0)

func _on_stun_timer_timeout():
	is_stunned = false
	modulate = Color(1, 1, 1, modulate.a) 
	if can_take_damage: modulate.a = 1.0

func die():
	var go_screen = get_tree().root.find_child("GameOver", true, false)
	if go_screen: go_screen.trigger_death()
