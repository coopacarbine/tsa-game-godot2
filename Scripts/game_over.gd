extends CanvasLayer

func _ready():
	# We hide the whole layer at the start so it doesn't block clicks
	hide() 
	# Make the actual black rectangle invisible
	$Fade_transition.modulate.a = 0

func trigger_death():
	# 1. Show the layer
	show()
	
	# 2. Reset the ColorRect visibility so it's ready to animate
	$Fade_transition.show()
	$Fade_transition.modulate.a = 1.0 # This fixes the error!
	
	if has_node("Fade_transition/animation_fade"):
		# Play the reveal (Black -> Transparent)
		$Fade_transition/animation_fade.play("fade_in")
	
	get_tree().paused = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_restart_button_pressed():
	if has_node("Fade_transition/animation_fade"):
		# Play the transition to black (Transparent -> Black)
		$Fade_transition/animation_fade.play("fade_out")
		await $Fade_transition/animation_fade.animation_finished
	
	GameManagerLvl1.reset_game()
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_continue_button_pressed():
	# Add the penalty
	GameManagerLvl1.total_deaths += 3
	
	# Update the display immediately so the player sees the penalty
	GlobalHud.update_death_display(GameManagerLvl1.total_deaths)
	if has_node("Fade_transition/animation_fade"):
		# Play the transition to black (Transparent -> Black)
		$Fade_transition/animation_fade.play("fade_out")
		await $Fade_transition/animation_fade.animation_finished
	
	# Transition to next scene
	get_tree().paused = false
	get_tree().change_scene_to_file("res://TSA Nationals Refine/cutscene_skip_1.tscn")
