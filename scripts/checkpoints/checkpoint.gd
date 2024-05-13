extends Node2D

@onready var animated_sprite = $AnimatedSprite2D
@onready var audio_stream_player: AudioStreamPlayer2D = $CheckpointSound
@onready var interactable_component: Area2D = $InteractableComponent

func _player_entered():
    animated_sprite.play("flag-out")
    audio_stream_player.play()
    await animated_sprite.animation_finished
    animated_sprite.play("idle")
    interactable_component.queue_free()
