extends Node
#lootbox vars
@onready var player2 = $"../player2"
var is_transitioning: bool = false
var canSpinBox = true
var items = ["heart", "running shoes", "apple", "tin can"]
var text = ""
var car = 300
var is_restarting: bool = false
var has_ended: bool = false
var lives = 3

func _ready():
	start_level_timer()

func start_level_timer():
	$"../Timer".play("TimerBack")
	await get_tree().create_timer(45.0).timeout
	endGame(1)

func _physics_process(delta):
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

func spinBox(delta):
	if canSpinBox == true && Input.is_action_just_pressed( "space"):
		
		$"../LootBox".play("open")
		canSpinBox = false
		await get_tree().create_timer(2.0).timeout
		$"../LootBox".play("idle")
		canSpinBox = true
		
		
		
		text = items.pick_random()
		if text == "heart":
			$"../powerupLabel".text = "Your Powerup Is: \nA Heart! \ngives your back one heart!"
			if lives < 3:
				lives = lives + 1
		if text == "running shoes":
			
			car = 400
			$"../powerupLabel".text = "Your Powerup Is: \n Running Shoes! \nMakes you run faster to the cars!"
		if text == "apple":
			$"../powerupLabel".text = "Your Powerup Is: \nA Apple! \nmakes you slower!"
			car = 200
		if text == "tin can":
			$"../powerupLabel".text = "Your Powerup Is: \nA Tin Can! \ngives you nothing!"
			
func checkSpeed():
	return car		
		
	
