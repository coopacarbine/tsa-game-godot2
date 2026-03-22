
extends Control 


@export var level_path : String = "res://Scenes/level1.tscn"

func _ready():

	$AnimationPlayer.play("AnimationWords")

func _on_animation_player_animation_finished(anim_name):

	if anim_name == "AnimationWords":
		_start_transition_sequence()

func _start_transition_sequence():

	await get_tree().create_timer(5.0).timeout
	
	
	if has_node("Fade_transition/animation_fade"):
		$Fade_transition/animation_fade.play("fade_in")
	
		await $Fade_transition/animation_fade.animation_finished
	
	get_tree().change_scene_to_file(level_path)

"""func _input(event):

	if event.is_action_pressed("ui_accept"):
		get_tree().change_scene_to_file(level_path)"""
