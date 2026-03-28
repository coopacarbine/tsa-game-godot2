extends Control

@export var ending_path : String = "res://ending_scene.tscn"

func _ready():
	$AnimationPlayer.play("AnimationWords4")
	if has_node("Fade_transition/animation_fade"):
		$Fade_transition/animation_fade.play("fade_out")

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "AnimationWords4":
		_return_to_menu_sequence()

func _return_to_menu_sequence():
	await get_tree().create_timer(2.0).timeout

	if has_node("Fade_transition/animation_fade"):
		$Fade_transition/animation_fade.play("fade_in") 
		await $Fade_transition/animation_fade.animation_finished

	get_tree().change_scene_to_file(ending_path)
