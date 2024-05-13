extends Node2D

@onready var animation_player = $AnimatedSprite2D
@onready var audio_stream_player: AudioStreamPlayer2D = $CheckpointSound
@onready var interactable_component: Area2D = $InteractableComponent

func _player_entered():
    interactable_component.queue_free()
    animation_player.play("flag-out")
    audio_stream_player.play()
    await animation_player.animation_finished
    animation_player.play("idle")
