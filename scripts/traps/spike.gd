extends Area2D

# TODO: Use composition

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group(Groups.PLAYER):
		return
	
	Events.PLAYER_DIED.emit()
