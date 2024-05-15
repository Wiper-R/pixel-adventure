extends PlayerState
class_name PlayerJumpState;

@export var fall_state: PlayerFallState;
@export var jump_particles: CPUParticles2D;
@export var jump_sound: AudioStreamPlayer;
@export var player_movement: PlayerMovement;

func on_enter() -> void:
    jump_particles.emitting = true;
    animation_player.play("jump")
    jump_sound.play()
    


func state_physics_process(delta: float) -> void:
    parent._handle_movement()
    parent._apply_gravity(delta)
    
    if parent.velocity.y > 0:
        next_state = fall_state;


func state_input(event: InputEvent) -> void:
    if event.is_action_released("jump") and parent.velocity.y < 0:
        parent.velocity.y *= player_movement.cut_jump_height
        
    if event.is_action_pressed("jump"):
        parent._handle_double_jump()
