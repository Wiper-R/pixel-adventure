extends Area2D

@onready var animated_sprite = $AnimatedSprite2D
@onready var collision_shape = $CollisionShape2D
@onready var confetti: Node2D = $Confetti


func _on_body_entered(body):
	if not body.is_in_group(Groups.PLAYER):
		return
	animated_sprite.play("pressed")
	confetti.emit_signal("confetti")
	await animated_sprite.animation_finished
	animated_sprite.play('idle')
	collision_shape.queue_free()
