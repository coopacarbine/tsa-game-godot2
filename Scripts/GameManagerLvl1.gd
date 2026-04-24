extends Node

var has_picked_up_vile: bool = false
var health: int = 3
var has_ended: bool = false
var total_deaths: int = 0

var saved_player_pos : Vector2 = Vector2.ZERO
var is_returning_from_talk : bool = false  # <--- Check this spelling!
# NEW: This acts as a master lock for health
var can_take_damage_global: bool = true

func lose_health():
	if not can_take_damage_global: return
	
	can_take_damage_global = false
	health -= 1
	
	var health_ui = get_tree().root.find_child("Health", true, false)
	if health_ui:
		health_ui.play("H" + str(health))
	
	# --- ADD THIS BACK ---
	if health <= 0:
		total_deaths += 1 # Add the death immediately
		# Tell the HUD right now
		if GlobalHud:
			GlobalHud.update_death_display(total_deaths)
	# ---------------------
	
	await get_tree().create_timer(0.5).timeout
	can_take_damage_global = true
func trigger_game_over():
	if has_ended: return
	has_ended = true
	
	# 1. ADD TO THE TOTAL
	total_deaths += 1
	print("DEATH RECORDED. Total now: ", total_deaths)
	
	# 2. TELL THE HUD TO SHOW THE NEW NUMBER
	# Make sure 'GlobalHUD' matches the name in your Autoload settings!
	if GlobalHud:
		GlobalHud.update_death_display(total_deaths)
	
	# 3. CALL THE SCREEN
	var go_screen = get_tree().root.find_child("GameOver", true, false)
	if go_screen:
		go_screen.trigger_death()
func reset_game():
	health = 3
	has_ended = false
	# total_deaths = 0  <-- DELETE THIS LINE IF YOU HAVE IT!
	print("Game Reset: Deaths preserved at ", total_deaths)
