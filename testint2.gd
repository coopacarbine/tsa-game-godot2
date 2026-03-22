extends StaticBody2D

signal object_activated

@onready var interaction_area = $InteractionArea

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")

func _on_interact():

	object_activated.emit()
	queue_free()
