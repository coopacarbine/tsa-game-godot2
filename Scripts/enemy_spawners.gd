extends Node2D

@export var robot_scene: PackedScene
@export var respawn_time: float = 3.0 # Set this to 3.0 or 5.0 seconds

func _ready():
	add_to_group("spawners")

# 1. The initial ambush (no wait here, usually)
func spawn_robot():
	# Play the alarm
	$AudioStreamPlayer.play()

	await get_tree().create_timer(3.0).timeout
	print("Vile picked up! Ambush starting in 3 seconds...")
	
	# 1. THE WAIT THING:
	# This tells the script: "Stop here, wait 3 seconds, then continue."
	await get_tree().create_timer(3.0).timeout
	
	# 2. THE AMBUSH:
	var markers = get_tree().get_nodes_in_group("spawners").filter(func(n): return n is Marker2D)
	
	for marker in markers:
		_create_robot_at(marker.global_position)
		
	print("Ambush initiated!")
# 2. The delayed respawn logic
func spawn_at_location(pos: Vector2):
	print("Robot destroyed. Waiting ", respawn_time, " seconds to respawn...")
	
	# The "Wait Thing": This pauses the function without freezing the game
	await get_tree().create_timer(respawn_time).timeout
	
	_create_robot_at(pos)
	print("Robot respawned at original location.")

func _create_robot_at(pos: Vector2):
	var robot_instance = robot_scene.instantiate()
	robot_instance.global_position = pos
	get_tree().current_scene.add_child(robot_instance)
