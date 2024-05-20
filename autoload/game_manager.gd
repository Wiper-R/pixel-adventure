extends Node


# TODO: Use setters/getters
var lives = 3;

func _ready():
    Events.PLAYER_DIED.connect(_on_player_died)
    
func _on_player_died():
    lives -= 1
    Events.PLAYER_LIVES_UPDATED.emit(lives)
