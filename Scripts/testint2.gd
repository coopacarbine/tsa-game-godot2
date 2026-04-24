extends StaticBody2D

@onready var interaction_area = $InteractionArea

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")

func _on_interact():
	print("--- INTERACT TRIGGERED ---")
	
	# Let's count how many dialogue boxes Godot sees
	var all_dialogues = get_tree().get_nodes_in_group("dialogue_box")
	print("Total nodes found in 'dialogue_box' group: ", all_dialogues.size())
	
	if all_dialogues.size() > 0:
		var diag = all_dialogues[0]
		diag.display_text("You have found the vile! Quick, before the robots come
		find the exit located at one of paths")
	else:
		# If this prints 0, the group name is misspelled or not added
		print("ERROR: Godot sees ZERO nodes in the group 'dialogue_box'")

	GameManagerLvl1.has_picked_up_vile = true
	get_tree().call_group("spawners", "spawn_robot")
	
	# Instead of queue_free, just hide the vial so we don't break the script
	self.visible = false
	self.set_deferred("process_mode", PROCESS_MODE_DISABLED)
