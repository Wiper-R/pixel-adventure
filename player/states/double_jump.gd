extends PlayerState;

class_name PlayerDoubleJumpState;

@export var fall_state: PlayerFallState;
@export var jump_particles: CPUParticles2D;
@export var jump_sound: AudioStreamPlayer;

func on_enter() -> void:
    animation_player.play("double_jump")
    jump_sound.play()
    jump_particles.emitting = true;

func state_physics_process(delta: float) -> void:
    parent._apply_gravity(delta)
    parent._handle_movement()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
    if anim_name == "double_jump":
        next_state = fall_state;
