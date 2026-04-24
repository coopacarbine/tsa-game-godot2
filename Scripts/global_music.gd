extends AudioStreamPlayer

func _ready():

	volume_db = -20.0 

	if has_node("AnimationPlayer"):
		$AnimationPlayer.play("music_fade_in")
	
	if !playing:
		play()
