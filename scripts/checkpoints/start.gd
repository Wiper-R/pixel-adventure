extends Node2D

@onready var animated_sprite = $AnimatedSprite2D

func _player_interacted():
    if animated_sprite.animation == "moving":
        return
        
    animated_sprite.play("moving")
    await animated_sprite.animation_finished
    animated_sprite.play("idle")
    
    # Handle Other logic here
