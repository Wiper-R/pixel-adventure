extends Node2D

@onready var animated_sprite = $AnimatedSprite2D
@onready var confetti: Node2D = $Confetti
@onready var interactable_component: Area2D = $InteractableComponent


func _player_entered():
    animated_sprite.play("pressed")
    confetti.emit_signal("confetti")
    await animated_sprite.animation_finished
    animated_sprite.play('idle')
    interactable_component.queue_free()
