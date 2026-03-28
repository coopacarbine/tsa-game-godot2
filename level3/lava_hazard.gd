extends Area2D

@onready var anim_player = $"../Fade_transition/animation_fade"


func _on_body_entered(body: Node2D) -> void:

	if body.name == "PlatformerPlayer":
		die()

func die():
	set_deferred("monitoring", false)

	if get_node_or_null("../PlatformerPlayer"):
		$"../PlatformerPlayer".set_physics_process(false)

	if anim_player.has_animation("fade_in"):
		anim_player.play("fade_in")

		await anim_player.animation_finished

	get_tree().reload_current_scene()
