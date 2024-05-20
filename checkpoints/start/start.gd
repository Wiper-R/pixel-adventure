extends Node2D
class_name StartCheckpoint

@onready var animation_player = $AnimatedSprite2D;


func _player_interacted():
    if animation_player.animation == "moving":
        return
        
    animation_player.play("moving")
    await animation_player.animation_finished
    animation_player.play("idle")
    
    # Handle Other logic here
