extends Node2D

@onready var dialogue_box = $Dialogue2
@onready var dialogue_timer = $Dialogue2/DialogueTimer
@onready var door_trigger = $DoorArea
@onready var fade_anim = $CanvasLayer/Fade_transition/animation_fade

# ADDED: This defines the player so the script knows who you're talking about
@onready var player = get_node_or_null("THE_HERO") 

var has_key: bool = false

func _ready():
	# 1. Show the HUD
	GlobalHud.show_hud()
	
	# 2. FORCE the text to update using the permanent data in GameManager
	GlobalHud.update_death_display(GameManagerLvl1.total_deaths)
	# 1. Safety unpause
	get_tree().paused = false
	if GameManagerLvl1.is_returning_from_talk:
		# CHANGED: Updated path to find "Player"
		var player_node = get_node("Player") 
		
		if player_node:
			# Snap the player back to the saved GPS spot
			player_node.global_position = GameManagerLvl1.saved_player_pos
		
		# Reset the flag so it doesn't loop
		GameManagerLvl1.is_returning_from_talk = false
	# 2. Sync the Visual Hearts
	var health_ui = find_child("Health", true, false)
	if health_ui:
		health_ui.play("H" + str(GameManagerLvl1.health))
	
	# 3. FORCE the Game Over screen to be hidden at start
	var go_screen = find_child("GameOver", true, false)
	if go_screen:
		go_screen.hide()
	
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	# 4. Brightness and Opening Fade
	GameSettings.apply_brightness(self)
	if fade_anim:
		# This reveals the level when you first start
		fade_anim.play("fade_out")

	# 5. Door Setup
	if door_trigger:
		print("Main is ready. Door monitoring is: ", door_trigger.monitoring)
		door_trigger.monitoring = false
	
	# 6. Player Check (No timer!)
	await get_tree().process_frame 
	if player == null:
		# Try finding by unique name if the path failed
		player = get_node_or_null("%THE_HERO")
		
	if player == null:
		print("Player not found in Level 1")

# --- SIGNAL LOGIC ---

func _on_objects_object_activated():
	print("SIGNAL RECEIVED: The key was picked up!")
	has_key = true
	door_trigger.monitoring = true
	print("Door monitoring is now: ", door_trigger.monitoring)
	
	if dialogue_box:
		dialogue_box.show()      
		dialogue_timer.start()

func _on_dialogue_timer_timeout():
	dialogue_box.hide()

func _on_body_entered(body: Node2D) -> void:
	if body.name == "THE_HERO":
		print("Player reached the door!")
		
		if fade_anim:
			# We want the screen to go BLACK (fade_in) before we change scenes
			fade_anim.play("fade_in")
			
			# Wait for the black screen to fully cover the level
			await fade_anim.animation_finished
		
		# Now change the scene to Level 2 or the next cutscene
		get_tree().change_scene_to_file("res://cutscene_2.tscn")
