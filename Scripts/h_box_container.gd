extends HBoxContainer

func _process(_delta):
	var current_health = GameManagerLvl1.health
	var hearts = get_children()
	
	for i in range(hearts.size()):
		if i < current_health:
			# Fully visible
			hearts[i].modulate.a = 1.0 
		else:
			# Turns the heart into a dark "ghost" version
			hearts[i].modulate = Color(0.2, 0.2, 0.2, 0.5)
