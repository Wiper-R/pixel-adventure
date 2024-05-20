extends PlayerState;
class_name PlayerDisabledState;


func on_enter() -> void:
    animation_player.play("idle")

func state_process(delta: float) -> void:
    parent.velocity.x = 0
    parent._apply_gravity(delta)
