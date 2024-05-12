extends Area2D

@onready var animated_sprite = $AnimatedSprite2D
@onready var collision_shape = $CollisionShape2D

func _play_moving_animation(body):
    if not body.is_in_group(Groups.PLAYER) || animated_sprite.animation == "moving":
        return
        
    animated_sprite.play("moving")
    await animated_sprite.animation_finished
    animated_sprite.play("idle")
    
    # Handle Other logic here
