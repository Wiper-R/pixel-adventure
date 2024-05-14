extends PlayerState
class_name PlayerDisappearingState;

func on_enter() -> void:
    animation_player.play("disappearing")
    parent.velocity.y = 0
    var tween = create_tween()
    tween.tween_property(parent, "modulate", Color(parent.modulate, 0), animation_player.current_animation_length)
    
    

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
    if anim_name == "disappearing":
        SceneManager.reload_scene()
