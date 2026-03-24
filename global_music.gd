extends AudioStreamPlayer

func _ready():
	$AnimationPlayer.play("music_fade_in")
	
	if !playing:
		play()
