extends Area2D 

@export var action_name: String = "collect vile"

# This is what the InteractionManager calls when you press 'E'
var interact: Callable = func():
	_on_vile_pickup()

func _on_vile_pickup():
	print("Vile obtained!")
	GameManagerLvl1.has_picked_up_vile = true
	
	# Trigger the robots
	get_tree().call_group("spawners", "spawn_robot")
	
	# Delete the jar (the root 'objects' node)
	if get_parent():
		get_parent().queue_free()

# These connect the Jar to your InteractionManager
func _on_body_entered(body: Node2D) -> void:
	
	if body.is_in_group("Player"):
		InteractionManager.register_area(self)

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		InteractionManager.unregister_area(self)
