extends Node2D

# Drag your jar scene here in the Inspector
@export var jar_scene: PackedScene 

func _ready():
	# Wait for the level to fully load
	await get_tree().process_frame
	
	spawn_single_jar()

func spawn_single_jar():
	var markers = get_children()
	
	if markers.size() > 0:
		var target_marker = markers.pick_random()
		var jar = jar_scene.instantiate()
		
		# Add to scene first so we can edit it
		get_tree().current_scene.add_child(jar)
		
		# Match position
		jar.global_position = target_marker.global_position
		
		# THE FIXES:
		jar.z_index = 10 # Force it above tiles
		
		# If you have a light on the marker, move it to the jar
		if target_marker.has_node("PointLight2D"):
			var light = target_marker.get_node("PointLight2D")
			light.enabled = true
			# Optional: move light to jar if you want the light to follow the jar
			# light.reparent(jar) 
			
		print("Level 1: Single jar spawned at ", target_marker.name)
