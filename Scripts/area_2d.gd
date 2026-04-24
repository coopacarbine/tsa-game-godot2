extends Area2D

func _on_body_entered(body):
	print("--- DOOR DEBUG ---")
	print("1. Something entered Area2D: ", body.name)
	
	if body.is_in_group("Player") or body.is_in_group("player"):
		print("2. Group Check: SUCCESS (Found Player)")
		
		print("3. Vile Status in GameManager: ", GameManagerLvl1.has_picked_up_vile)
		if GameManagerLvl1.has_picked_up_vile == true:
			print("4. Transition: STARTING")
			start_the_exit_sequence()
		else:
			print("4. Transition: BLOCKED (Vile not picked up)")
	else:
		print("2. Group Check: FAILED (Body not in 'Player' group)")

func start_the_exit_sequence():
	var fade_player = owner.find_child("animation_fade", true, false)
	if fade_player:
		print("5. AnimationPlayer: FOUND. Playing 'fade_in'...")
		fade_player.play("fade_in")
		await fade_player.animation_finished
		print("6. Animation: FINISHED. Changing scene...")
		get_tree().change_scene_to_file("res://cutscene_2.tscn")
	else:
		print("5. AnimationPlayer: NOT FOUND! Check node name 'animation_fade'.")
		get_tree().change_scene_to_file("res://cutscene_2.tscn")
