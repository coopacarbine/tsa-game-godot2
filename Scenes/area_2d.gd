extends Area2D

func _on_body_entered(body):
	if body.is_in_group("player"):

		var fade_player = owner.get_node("CanvasLayer/Fade_transition/animation_fade")
		

		if fade_player == null:
			fade_player = owner.find_child("animation_fade", true, false)

		if fade_player:
			print("Found yellow node! Fading now...")
			fade_player.play("fade_in")
			await fade_player.animation_finished
			get_tree().change_scene_to_file("res://main_menu.tscn")
		else:
			print("Error: Still can't find 'animation_fade'. Check capitalization!")
