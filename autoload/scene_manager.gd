extends Node2D


@onready var transition: TransitionAnimation = $BarsTransition

func change_scene(scene: PackedScene) -> void:
    await transition._transition_in()
    get_tree().change_scene_to_packed(scene)
    await transition._transition_out()
    
func reload_scene() -> void:
    await transition._transition_in()
    get_tree().paused = true
    get_tree().reload_current_scene()
    await transition._transition_out()
    get_tree().paused = false;

func _ready() -> void:
    # TODO: Use different logic to stop player animation
    get_tree().paused = true
    await transition._transition_out()
    get_tree().paused = false
