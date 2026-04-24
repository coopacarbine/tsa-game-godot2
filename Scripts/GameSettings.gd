extends Node


var brightness_value: float = 1.0
var music_muted: bool = false

func apply_brightness(target_node: Node):
	target_node.modulate = Color(brightness_value, brightness_value, brightness_value)
