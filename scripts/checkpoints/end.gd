extends Node2D

@onready var animation_player = $AnimatedSprite2D
@onready var confetti: Node2D = $Confetti
@onready var interactable_component: Area2D = $InteractableComponent


func _player_entered():
    animation_player.play("pressed")
    confetti.emit_signal("confetti")
    await animation_player.animation_finished
    animation_player.play('idle')
    interactable_component.queue_free()
