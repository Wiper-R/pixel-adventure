extends Node2D

enum Transition{
    BARS,
    FADE
}
@onready var bars_transition: TransitionAnimation = $BarsTransition
@onready var fade_transition: TransitionAnimation = $FadeTransition

func get_transition(transition: Transition) -> TransitionAnimation:
    match transition:
        Transition.BARS:
            return bars_transition;
        Transition.FADE:
            return fade_transition;
        
    return null;

func change_scene(scene: PackedScene, transition: Transition = Transition.BARS) -> void:
    var _transition = get_transition(transition)
    if _transition:
        await _transition._transition_in()
    get_tree().change_scene_to_packed(scene)
    if _transition:
        await _transition._transition_out()
    
func reload_scene(transition: Transition = Transition.BARS) -> void:
    var _transition = get_transition(transition)
    if _transition:
        await _transition._transition_in()
    get_tree().paused = true
    get_tree().reload_current_scene()
    if _transition:
        await _transition._transition_out()
    get_tree().paused = false;

func _ready() -> void:
    # TODO: Use different logic to stop player animation
    get_tree().paused = true
    await bars_transition._transition_out()
    get_tree().paused = false
