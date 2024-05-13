extends PlayerState;

class_name PlayerAirState;

@export var gravity_multiplier: float = 1;
@export var fall_multiplier: float = 1.2;
@export var max_fall_speed: float = 400;
@export var player: Player;
@export var ground_state: PlayerGroundState;


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func state_input(event: InputEvent):
    if event.is_action_pressed("jump"):
        ground_state.jump_buffer_timer = ground_state.jump_buffer_time;

func _apply_gravity(delta: float):
    var mult = gravity_multiplier;
    
    if player.velocity.y > 0:
        mult *= fall_multiplier;
        
    player.velocity.y += gravity * delta * mult;
    player.velocity.y = clamp(player.velocity.y, ground_state.jump_force, max_fall_speed)


func state_physics_process(delta: float):
    if player.velocity.y > 0 and not player.died:
        playback.travel("fall")
        
    _apply_gravity(delta)
    
    if player.is_on_floor():
        next_state = ground_state;
        
func on_exit():
    playback.travel("move")
