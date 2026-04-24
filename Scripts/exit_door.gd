extends Area2D

func _on_body_entered(body):
	# 1. THE PHYSICS PING
	print("--- EXIT DOOR TRIGGERED BY: ", body.name, " ---")
	
	# 2. THE IDENTITY CHECK
	if body.is_in_group("Player") or body.is_in_group("player") or body.name == "THE_HERO":
		print("Checkpoint: Player identity confirmed.")
		
		# 3. THE QUEST CHECK
		if GameManagerLvl1.has_picked_up_vile == true:
			print("Checkpoint: Vile check passed. Initiating transition...")
			
			# Freeze the player so they don't walk off screen during the fade
			if body.get("is_stunned") != null:
				body.is_stunned = true
				body.velocity = Vector2.ZERO
			
			start_the_exit_sequence()
		else:
			print("Checkpoint: Vile check FAILED. Player hasn't picked up the serum.")

func start_the_exit_sequence():
	# 1. FIND AND DISABLE ALL ENEMIES
	# This finds every node in your "enemies" group
	var all_enemies = get_tree().get_nodes_in_group("Enemies")
	
	for enemy in all_enemies:
		# Stop them from moving
		enemy.set_physics_process(false)
		enemy.set_process(false)
		
		# IMPORTANT: Disable their hitboxes so they can't 'touch' you
		# We use find_child to look for the CollisionShape2D inside the robot
		var hitbox = enemy.find_child("CollisionShape2D", true, false)
		if hitbox:
			hitbox.set_deferred("disabled", true)
			
		# Optional: Make them semi-transparent so it looks like they are 'deactivated'
		enemy.modulate.a = 0.5

	# 2. START THE FADE
	var fade_player = get_tree().root.find_child("animation_fade", true, false)
	if fade_player:
		fade_player.get_parent().show()
		fade_player.play("fade_in")
		await fade_player.animation_finished
		get_tree().change_scene_to_file("res://Scenes/cutscene_2.tscn")
