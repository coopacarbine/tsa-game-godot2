extends Area2D

@onready var fade_player = $"../Fade_transition/animation_fade"
@onready var sparks = $GPUParticles2D 

@onready var sfx_teleport = $AudioStreamPlayer2D 

@export var target_scene = "res://cutscene_4.tscn"

func _on_body_entered(body: Node2D) -> void:
	if body.name == "PlatformerPlayer":
		finish_game()

func finish_game():

	if get_node_or_null("../PlatformerPlayer"):
		$"../PlatformerPlayer".set_physics_process(false)

	sfx_teleport.play()
	sparks.restart()
	sparks.emitting = true

	await get_tree().create_timer(0.8).timeout

	fade_player.play("fade_in")
	await fade_player.animation_finished

	get_tree().change_scene_to_file(target_scene)
