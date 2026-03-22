extends Node2D

var button_type = null


@onready var fade_anim = $Fade_transition/animation_fade
@onready var fade_node = $Fade_transition
@onready var fade_timer = $Fade_transition/Fade_timer

func _on_start_pressed():
	button_type = "start"
	start_transition()

func _on_options_pressed():
	button_type = "options"
	start_transition()

func _on_quit_pressed():
	get_tree().quit()


func start_transition():
	fade_node.show()
	fade_timer.start()
	fade_anim.play("fade_in")

func _on_fade_timer_timeout():
	if button_type == "start":
		get_tree().change_scene_to_file("res://cutscene_1.tscn")
	elif button_type == "options":
		
		get_tree().change_scene_to_file("res://options_menu.tscn")
