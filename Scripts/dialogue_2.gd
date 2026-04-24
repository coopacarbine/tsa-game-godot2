extends Control

# This function will be called by the Vial
func display_text(message):
	$MarginContainer/Panel/Label.text = message
	show() # Make the box visible
	$DialogueTimer.start(3.0) # Start the 3-second countdown

func _on_dialogue_timer_timeout():
	hide() # Hide it after 3 seconds
