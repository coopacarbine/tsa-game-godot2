extends MarginContainer

func _ready():
	hide() # Start invisible

func display_text(message):
	# Update the text to whatever the Vial sends
	%Label.text = message
	
	# Make the box visible
	show()
	
	# Start the 5-second countdown
	# Make sure %DialogueTimer matches the Unique Name in your tree!
	%DialogueTimer.start(5.0)

func _on_dialogue_timer_timeout():
	hide() # Disappear after 5 seconds
