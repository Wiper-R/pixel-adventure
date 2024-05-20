extends Area2D



signal player_entered;
signal player_exited;

func _init() -> void:
    monitoring = false

func _ready() -> void:
    await get_tree().physics_frame
    await get_tree().physics_frame
    monitoring = true;
    

func _on_body_entered(body: Node2D) -> void:
    if not body.is_in_group(Groups.PLAYER):
        return
    
    player_entered.emit()
    


func _on_body_exited(body: Node2D) -> void:
    if not body.is_in_group(Groups.PLAYER):
        return
    
    player_exited.emit()
