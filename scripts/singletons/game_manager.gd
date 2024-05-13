extends Node

func _ready():
    Events.PLAYER_DIED.connect(_on_player_died)
    
func _on_player_died():
    print("Player Died")
