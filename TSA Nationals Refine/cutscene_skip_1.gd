extends Control

# This lets you pick the next level in the Inspector for each cutscene
@export var next_scene_path: String = "res://Scenes/lvl2.tscn"

@onready var anim = $AnimationPlayer
@onready var story_label = $StoryLabel

func _ready():
	# 1. Hide the Global HUD immediately
	if GlobalHud:
		GlobalHud.hide_hud()
	
	
	# Give the player a tiny half-second of black screen before typing starts
	await get_tree().create_timer(0.5).timeout
	
	anim.play("AnimationWords2")

# Connect the AnimationPlayer's "animation_finished" signal to this function
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	# This triggers after the text finishes typing and the fade-out keys finish
	if anim_name == "AnimationWords2":
		print("Cutscene finished. Moving to: ", next_scene_path)
		if has_node("Fade_transition/animation_fade"):
		
			$Fade_transition/animation_fade.play("fade_in")
			await $Fade_transition/animation_fade.animation_finished
			
		get_tree().change_scene_to_file(next_scene_path)
