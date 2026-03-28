extends Control 

@export var level_path : String = "res://Scenes/level1.tscn"
var is_skipping : bool = false

func _ready():
	$AnimationPlayer.play("AnimationWords")

func _unhandled_input(event):
	if event.is_action_pressed("ui_accept"):
		get_tree().change_scene_to_file(level_path)

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "AnimationWords" and not is_skipping:
		_start_transition_sequence()

func _start_transition_sequence():
	await get_tree().create_timer(5.0).timeout
	
	if not is_skipping:
		perform_fade_and_swap()

func skip_to_level():
	is_skipping = true
	get_tree().change_scene_to_file(level_path)

func perform_fade_and_swap():
	if has_node("Fade_transition/animation_fade"):
		$Fade_transition/animation_fade.play("fade_in")
		await $Fade_transition/animation_fade.animation_finished
	
	get_tree().change_scene_to_file(level_path)
