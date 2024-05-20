extends PlayerState;
class_name PlayerAppearingState;

@export var idle_state: PlayerIdleState;

func on_enter() -> void:
    animation_player.play("appearing")
    parent.sprite.self_modulate = Color(parent.sprite.self_modulate, 0)
    
func on_exit() -> void:
    parent.sprite.self_modulate = Color(parent.sprite.self_modulate, 1)

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
    if anim_name == "appearing":
        next_state = idle_state;
    
        
