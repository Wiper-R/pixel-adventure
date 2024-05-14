extends PlayerState;
class_name PlayerAppearingState;

@export var idle_state: PlayerIdleState;

func on_enter() -> void:
    animation_player.play("appearing")
    var tween = create_tween()
    parent.modulate = Color(parent.modulate, 0)
    tween.tween_property(parent, "modulate", Color(parent.modulate, 1), animation_player.current_animation_length)


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
    if anim_name == "appearing":
        next_state = idle_state;
