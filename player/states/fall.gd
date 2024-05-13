extends PlayerState;
class_name PlayerFallState;

var gravity = ProjectSettings.get("physics/2d/default_gravity")

@export var gravity_multiplier: float = 1;
@export var fall_multiplier: float = 2.5;
@export var jump_state: PlayerJumpState;
@export var max_fall_speed: float = 400;

@export var idle_state: PlayerIdleState;


func on_enter() -> void:
    playback.travel("fall")
    
func state_physics_process(delta: float):
    parent._handle_movement()
    parent._handle_jump()
    parent._apply_gravity(delta)
    
    if parent.is_on_floor():
        next_state = idle_state
