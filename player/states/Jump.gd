extends PlayerState
class_name PlayerJumpState;

@export var fall_state: PlayerFallState;
@export var jump_particles: CPUParticles2D;

func on_enter() -> void:
    jump_particles.emitting = true;
    playback.travel("jump")


func state_physics_process(delta: float) -> void:
    parent._handle_movement()
    parent._apply_gravity(delta)
    
    if parent.velocity.y > 0:
        next_state = fall_state;
