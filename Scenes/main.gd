extends Node2D

@onready var dialogue_box = $Dialogue2
@onready var dialogue_timer = $Dialogue2/DialogueTimer
@onready var door_trigger = $DoorArea
@onready var fade_anim = $CanvasLayer/Fade_transition/animation_fade

var has_key: bool = false

func _ready():

	if fade_anim:
		fade_anim.play("fade_out")
	

	if door_trigger:
		print("Main is ready. Door monitoring is: ", door_trigger.monitoring)
		door_trigger.monitoring = false
	
func _on_objects_object_activated():
	print("SIGNAL RECEIVED: The key was picked up!")
	has_key = true
	door_trigger.monitoring = true
	print("Door monitoring is now: ", door_trigger.monitoring)
	$Dialogue.queue_free()
	
	if dialogue_box:
		dialogue_box.show()      
		dialogue_timer.start()


func _on_dialogue_timer_timeout():
	dialogue_box.hide()
