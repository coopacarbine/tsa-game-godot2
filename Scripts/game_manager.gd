extends Node
#lootbox vars
@onready var player2 = $"../player2"

var canSpinBox = true
var items = ["heart", "running shoes", "apple", "tin can"]
var text = ""
var car = 300


var lives = 3
func _physics_process(delta):
	spinBox(delta)
	timer(delta)
	
	
	
	

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
	if ending == 0:
		print("you died")
	if ending == 1:
		print("you win")


func timer(delta):
	$"../Timer".play("TimerBack")
	await get_tree().create_timer(45.0).timeout
	endGame(1)
	

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
		
	
