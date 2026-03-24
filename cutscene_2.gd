extends Control


@export var menu_path : String = "res://main_menu.tscn"

func _ready():
	# Play your text animation
	$AnimationPlayer.play("AnimationWords2")
	
	# If you want a fade-in at the very start of the cutscene:
	if has_node("Fade_transition/animation_fade"):
		$Fade_transition/animation_fade.play("fade_out")

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "AnimationWords2":
		_return_to_menu_sequence()

func _return_to_menu_sequence():
	# Short delay so the player can read the last bit of text
	await get_tree().create_timer(2.0).timeout
	
	# Trigger the Fade In (Screen goes black)
	if has_node("Fade_transition/animation_fade"):
		$Fade_transition/animation_fade.play("fade_in")
		await $Fade_transition/animation_fade.animation_finished
	
	# Send them back home
	get_tree().change_scene_to_file(menu_path)
