extends Node2D

class_name Checkpoint

static var last_checkpoint: Checkpoint;


@onready var animation_player = $AnimatedSprite2D
@onready var checkpoint_sound: AudioStreamPlayer = $CheckpointSound
@onready var interactable_component: Area2D = $InteractableComponent

func _player_entered():
    last_checkpoint = self;
    interactable_component.queue_free()
    animation_player.play("flag-out")
    checkpoint_sound.play()
    await animation_player.animation_finished
    animation_player.play("idle")
