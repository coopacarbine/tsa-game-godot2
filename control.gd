extends Control

@onready var brightness_slider = $VBoxContainer/BrightnessBox/HSlider
# Make sure this name matches your CheckButton node exactly!
@onready var music_tick_box = $VBoxContainer/MusicBox/CheckButton

func _ready():
	# Load the saved values so the sliders are in the right spot
	brightness_slider.value = GameSettings.brightness_value
	music_tick_box.button_pressed = !GameSettings.music_muted
	
	# Apply the brightness to THIS menu so it doesn't look bright while we are in it
	GameSettings.apply_brightness(self)

func _on_h_slider_value_changed(value: float):
	GameSettings.brightness_value = value
	# Apply to the whole scene
	if get_tree().current_scene:
		get_tree().current_scene.modulate = Color(value, value, value)

func _on_check_button_toggled(toggled_on: bool):
	GameSettings.music_muted = !toggled_on
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), !toggled_on)

# THIS IS THE MISSING PIECE:
	

func _on_button_pressed():
	if has_node("Fade_transition/animation_fade"):
		var fade_anim = $Fade_transition/animation_fade
		var fade_node = $Fade_transition
		
		fade_node.show()
		fade_anim.play("fade_in")

		await fade_anim.animation_finished
	get_tree().change_scene_to_file("res://main_menu.tscn")
