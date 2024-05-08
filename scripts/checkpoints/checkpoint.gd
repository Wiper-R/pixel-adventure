extends Area2D

@onready var animated_sprite = $AnimatedSprite2D
@onready var collision_shape = $CollisionShape2D

func _on_body_entered(body):
	if not body.is_in_group("player"):
		return
	animated_sprite.play("flag-out")
	await animated_sprite.animation_finished
	animated_sprite.play("idle")
	collision_shape.queue_free()
