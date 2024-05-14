extends Node2D
class_name Fruit
@onready var audio: AudioStreamPlayer = $AudioStreamPlayer

enum FruitType {
    Apple,
    Bananas,
    Cherries,
    Kiwi,
    Melon,
    Orange,
    Pineapple,
    Strawberry,
}

var fruit_type: FruitType  = FruitType.Apple;

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var interactable_component: Area2D = $InteractableComponent

func _ready() -> void:
    animated_sprite.play(fruit_type_to_string(fruit_type))

func fruit_type_to_string(fruit_type: FruitType) -> String:
    return FruitType.keys()[fruit_type].to_lower()

func _on_interactable_component_player_entered() -> void:
    interactable_component.queue_free()
    animated_sprite.play("collected")
    audio.play()
    await animated_sprite.animation_finished
    visible = false;
    await audio.finished
    queue_free()
