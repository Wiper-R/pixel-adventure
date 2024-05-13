extends Area2D



signal player_entered;
signal player_exited;

func _on_body_entered(body: Node2D) -> void:
    if not body.is_in_group(Groups.PLAYER):
        return
    
    player_entered.emit()
    


func _on_body_exited(body: Node2D) -> void:
    if not body.is_in_group(Groups.PLAYER):
        return
    
    player_exited.emit()
