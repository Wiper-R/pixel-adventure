extends PlayerState;
class_name PlayerDiedState;


func on_enter() -> void:
    animation_player.play("hit")

func state_physics_process(delta: float) -> void:
    parent._apply_gravity(delta)
