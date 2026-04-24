extends Node
#lootbox vars
# The % symbol finds a node with a "Unique Name" anywhere in the current scene

var is_transitioning: bool = false


var text = ""
var car = 400
var is_restarting: bool = false
var has_ended: bool = false
var lives = 3
var timerIndex = 0


func _ready():
	start_level_timer()
	$"../road".play("road")


@onready var player = get_node("/root/Lvl2/THE_HERO") 

func _ready():
	await get_tree().process_frame 
	if player == null:
		print("CRITICAL ERROR")
	else:
		start_level_timer() # This calls the function

# This MUST be all the way to the left (no tabs)
func start_level_timer():
	$"../Timer".play("TimerBack")
	while timerIndex < 45:
		await get_tree().create_timer(1.0).timeout
		timerIndex = timerIndex + 1
		car = (10 * timerIndex) + 400
	
	endGame(1)


func _physics_process(delta):
	if player == null:
		player = get_node_or_null("%THE_HERO")
		if player != null:
			print("FOUND HIM! He just took a second to load.")
	spinBox(delta)
	
	

	
	
func start_2_transition():
	if is_restarting: return
	is_restarting = true
	var fade_layer = $"../Fade_transition2"
	var fade_anim = $"../Fade_transition2/Fade_transition/animation_fade"
	if fade_layer and fade_anim:
		fade_layer.show()
		fade_anim.play("fade_in")
		await fade_anim.animation_finished
		get_tree().reload_current_scene()
	else:
		print("Error: Could not find Fade_transition2 or the animation player!")
		get_tree().reload_current_scene()

func start_cut3_transition():
	if is_transitioning:
		return
	is_transitioning = true
	
	var fade_layer = $"../Fade_transition2"
	var fade_anim = $"../Fade_transition2/Fade_transition/animation_fade"
	
	if fade_layer and fade_anim:
		fade_layer.show()
		fade_anim.play("fade_in")
		await fade_anim.animation_finished

	if is_inside_tree():
		get_tree().change_scene_to_file("res://cutscene_3.tscn")

func remove_lives():
	lives = lives - 1
	if lives == 3:
		$"../Health".play("H3")
	if lives == 2:
		$"../Health".play("H2")
		
	if lives == 1:
		$"../Health".play("H1")
	if lives <= 0:
		$"../Health".play("H0")
		endGame(0)
	
func endGame(ending):
	if has_ended:
		return
	has_ended = true
	
	if ending == 0:
		start_2_transition()
	elif ending == 1:
		print("Final Win Triggered!")
		start_cut3_transition()


func checkSpeed():
	return car		
		
	
