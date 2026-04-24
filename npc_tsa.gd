extends Area2D

@onready var prompt_label = $Label 

func _ready():
	print("DEBUG: NPC_TSA is ready. Searching for Label...")
	if prompt_label:
		print("DEBUG: Label found! Hiding it now.")
		prompt_label.hide()
	else:
		print("DEBUG ERROR: Label node not found! Check your scene tree names.")

	# Connecting signals
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	print("DEBUG: Something entered the area: ", body.name)
	if body.name == "Player":
		print("DEBUG: Player detected! Showing label.")
		prompt_label.show()

func _on_body_exited(body):
	if body.name == "Player":
		print("DEBUG: Player left. Hiding label.")
		prompt_label.hide()

func _input(event):
	if event.is_action_pressed("interact"):
		print("DEBUG: 'E' key pressed.")
		
		# Let's check who is overlapping right now
		var current_bodies = get_overlapping_bodies()
		print("DEBUG: Bodies currently overlapping: ", current_bodies)
		
		for body in current_bodies:
			if body.name == "Player":
				print("DEBUG: Success! Talking to Player. Saving position...")
				GameManagerLvl1.saved_player_pos = body.global_position
				GameManagerLvl1.is_returning_from_talk = true
				get_tree().change_scene_to_file("res://dialogue_realm.tscn")
				return
		
		print("DEBUG: 'E' was pressed but Player was not in the detection area.")
