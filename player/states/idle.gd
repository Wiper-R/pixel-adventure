extends PlayerState

class_name PlayerIdleState;

@export var jump_state: PlayerJumpState;
@export var fall_state: PlayerFallState;
@export var run_state: PlayerRunState;

func on_enter() -> void:
    animation_player.play("idle")
    
    

func state_physics_process(delta: float) -> void:
    parent._handle_movement()
    parent._handle_jump()
    parent._apply_gravity(delta)
    
    if abs(parent.velocity.x) > 0:
        next_state = run_state
        
    if not parent.is_on_floor():
        next_state = fall_state;
        
