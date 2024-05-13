extends PlayerState;

class_name PlayerGroundState;

@export var jump_buffer_time: float = 0.1;
@export var cayote_time: float = 0.25;

var jump_buffer_timer: float = 0;
var cayote_timer: float = 0;

@export var jump_force: float = -400;
@export var player: Player;
@export var air_state: PlayerAirState;
@export var jump_particles: CPUParticles2D;
@export var run_particles: CPUParticles2D;
@export var run_particles_timer: Timer;
@export var jump_sound: AudioStreamPlayer2D;


func state_input(event: InputEvent):
    if event.is_action_pressed("jump"):
        jump_buffer_timer = jump_buffer_time;


func _update_timers(delta: float):
    jump_buffer_timer -= delta
    cayote_timer -= delta
    
func state_process(delta: float) -> void:
    cayote_timer = cayote_time;

func _process(delta: float) -> void:
     _update_timers(delta)
    
func state_physics_process(delta: float) -> void:
    if not player.is_on_floor():
        next_state = air_state;
    
func _physics_process(delta: float) -> void:
    _handle_jump()

func on_enter() -> void:
    run_particles_timer.start()

func on_exit() -> void:
    run_particles_timer.stop()
    
        
func _handle_jump() -> void:
    if jump_buffer_timer > 0 && cayote_timer > 0:
        player.velocity.y = jump_force
        cayote_timer = 0
        jump_particles.emitting = true;
        jump_sound.play()
        playback.travel("jump")


func _on_timer_timeout() -> void:
    if abs(player.velocity.x) > 0:
        run_particles.emitting = true;
