extends Control

@export var menu_path : String = "res://main_menu.tscn"

var button_type = null 

@onready var fade_anim = $Fade_transition/animation_fade
@onready var text_player = $TextPlayer

func _ready():
	text_player.play("scroll_text")
	if has_node("Fade_transition/animation_fade"):
		fade_anim.play("fade_out")

func _on_menu_button_pressed():
	button_type = "quit"
	start_transition()

func _on_quit_button_pressed():
	button_type = "menu"
	start_transition()

func start_transition():
	if has_node("Fade_transition"):
		$Fade_transition.show()
	if has_node("Fade_transition/animation_fade"):
		fade_anim.play("fade_in")
		await fade_anim.animation_finished
		_on_transition_finished()

func _on_transition_finished():
	if button_type == "menu":
		get_tree().change_scene_to_file(menu_path)
	elif button_type == "quit":
		get_tree().quit()
