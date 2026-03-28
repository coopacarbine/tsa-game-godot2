extends Control

@onready var brightness_slider = $VBoxContainer/BrightnessBox/HSlider

@onready var music_tick_box = $VBoxContainer/MusicBox/CheckButton

func _ready():
	brightness_slider.value = GameSettings.brightness_value
	music_tick_box.button_pressed = !GameSettings.music_muted
	GameSettings.apply_brightness(self)

func _on_h_slider_value_changed(value: float):
	GameSettings.brightness_value = value
	if get_tree().current_scene:
		get_tree().current_scene.modulate = Color(value, value, value)

func _on_check_button_toggled(toggled_on: bool):
	GameSettings.music_muted = !toggled_on
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), !toggled_on)
	

func _on_button_pressed():
	if has_node("Fade_transition/animation_fade"):
		var fade_anim = $Fade_transition/animation_fade
		var fade_node = $Fade_transition
		
		fade_node.show()
		fade_anim.play("fade_in")

		await fade_anim.animation_finished
	get_tree().change_scene_to_file("res://main_menu.tscn")
