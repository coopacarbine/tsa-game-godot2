extends Area2D
@onready var game_manager = $"../../gameManager"

func _on_body_entered(body):
	
	game_manager.remove_lives()
	
	
