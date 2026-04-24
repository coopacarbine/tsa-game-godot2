extends Control

@onready var anim = $AnimationPlayer
@onready var label = $MarginContainer/Panel/DialogueLabel

func _ready():
	if GlobalHud: GlobalHud.hide_hud()
	$AudioStreamPlayer.play()
	# Reset and start typewriter
	$MarginContainer/Panel/DialogueLabel.visible_characters = 0
	anim.play("typewriter")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "typewriter":
		# The 5-second wait you requested
		await get_tree().create_timer(5.0).timeout
		if has_node("Fade_transition/animation_fade"):
		# Play the transition to black (Transparent -> Black)
			$Fade_transition/animation_fade.play("fade_in")
			await $Fade_transition/animation_fade.animation_finished
		# Go back to Level 1
			get_tree().change_scene_to_file("res://Scenes/level1.tscn")
