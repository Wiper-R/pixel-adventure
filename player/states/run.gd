extends PlayerState;
class_name PlayerRunState;

@export var idle_state: PlayerIdleState;
@export var fall_state: PlayerFallState;
@export var run_particles: CPUParticles2D;
@export var run_partciles_timer: Timer;


func on_enter() -> void:
    animation_player.play("run")
    run_partciles_timer.start()
    run_partciles_timer.timeout.connect(_emit_run_particles)
    
func on_exit() -> void:
    run_partciles_timer.stop()
    run_partciles_timer.timeout.disconnect(_emit_run_particles)

func state_physics_process(delta: float):
    parent._handle_movement()
    parent._handle_jump()
    parent._apply_gravity(delta)
    
    if parent.velocity.x == 0:
        next_state = idle_state
        
    if not parent.is_on_floor():
        next_state = fall_state;



func _emit_run_particles() -> void:
    run_particles.emitting = true;
