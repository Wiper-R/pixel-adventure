extends Node2D

class_name Checkpoint



@onready var animation_player = $AnimatedSprite2D
@onready var checkpoint_sound: AudioStreamPlayer = $CheckpointSound
@onready var interactable_component: Area2D = $InteractableComponent
@export var next_area_scene: PackedScene;

func _ready() -> void:
    assert(next_area_scene, "Next area scene not set")

func _player_entered():
    Events.PLAYER_TOUCHED_CHECKPOINT.emit(self)
    interactable_component.queue_free()
    animation_player.play("flag-out")
    checkpoint_sound.play()
    await animation_player.animation_finished
    animation_player.play("idle")
    Events.LOAD_NEXT_AREA.emit(next_area_scene)
