extends Control 

@export var level_path : String = "res://Scenes/world.tscn"

func _ready():
	# 1. Start fully black (Alpha = 1)
	$Fade_transition.modulate.a = 1.0
	$Fade_transition.show()
	
	# 2. Fade OUT to reveal the scene (Alpha 1.0 -> 0.0)
	var tween_out = create_tween()
	tween_out.tween_property($Fade_transition, "modulate:a", 0.0, 1.0)
	
	# 3. Start your text animation
	$AnimationPlayer.play("AnimationWords")

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "AnimationWords":
		_start_transition_sequence()

func _start_transition_sequence():
	# Wait 5 seconds
	await get_tree().create_timer(5.0).timeout
	
	# 4. Fade IN to black before the level (Alpha 0.0 -> 1.0)
	var tween_in = create_tween()
	tween_in.tween_property($Fade_transition, "modulate:a", 1.0, 1.0)
	
	# Wait for this specific tween to finish
	await tween_in.finished
	
	# Change scene
	get_tree().change_scene_to_file(level_path)


"""extends Control 


@export var level_path : String = "res://Scenes/world.tscn"

func _ready():

	$AnimationPlayer.play("AnimationWords")

func _on_animation_player_animation_finished(anim_name):

	if anim_name == "AnimationWords":
		_start_transition_sequence()

func _start_transition_sequence():

	await get_tree().create_timer(5.0).timeout
	
	
	if has_node("Fade_transition/AnimationPlayer"):
		$Fade_transition/AnimationPlayer.play("fade_in")
	
		await $Fade_transition/AnimationPlayer.animation_finished
	
	get_tree().change_scene_to_file(level_path)

func _input(event):

	if event.is_action_pressed("ui_accept"):
		get_tree().change_scene_to_file(level_path)"""
