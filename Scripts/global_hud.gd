extends CanvasLayer

# This matches the call from the GameManager
func update_death_display(count):
	# Make sure 'DeathCounter' is the exact name of the Label node
	if has_node("DeathCounter"):
		$DeathCounter.text = "Total Deaths: " + str(count)

func hide_hud():
	self.hide()

func show_hud():
	self.show()
