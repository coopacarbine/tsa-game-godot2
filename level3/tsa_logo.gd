extends Area2D

@onready var panel = %Panel

func _on_body_entered(body: Node2D) -> void:
	if body.name == "PlatformerPlayer":

		panel.show() 

func _on_body_exited(body: Node2D) -> void:
	if body.name == "PlatformerPlayer":

		panel.hide()
