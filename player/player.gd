extends CharacterBody2D

class_name Player

@export var movement_speed = 250.0
@export var state_machine: PlayerStateMachine;
@export var player_movement: PlayerMovement;
@export var jump_state: PlayerJumpState;
@export var died_state: PlayerDiedState;
@export var appearing_state: PlayerAppearingState;
@export var disappearing_state: PlayerDisappearingState;
@export var double_jump_state: PlayerDoubleJumpState;

@onready var camera: MainCamera = $Camera2D;
@onready var animation_player = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D


var died: bool = false;
var gravity = ProjectSettings.get("physics/2d/default_gravity")

# TODO: Handle dying properly



func _ready():
    #Engine.time_scale = .2;
    add_to_group(Groups.PLAYER)
    Events.PLAYER_DIED.connect(_died)
    Events.PLAYER_TOUCHED_CUP.connect(_reached_cup)
    


func _handle_input():
    var raw_dir = Input.get_axis("move_left", "move_right")
    if raw_dir > 0:
        raw_dir = 1
    elif raw_dir < 0:
        raw_dir = -1
    else:
        raw_dir = 0;
        
    player_movement.direction = raw_dir;

func _process(delta: float):
    _handle_input()
    _handle_animation()
    
func _handle_movement():
    if player_movement.direction:
        velocity.x = player_movement.direction * movement_speed
    else:
        velocity.x = move_toward(velocity.x, 0, movement_speed)
        
func _apply_gravity(delta: float):
    var mult = player_movement.gravity_mutiplier;
    
    if velocity.y > 0:
        mult *= player_movement.fall_multiplier;
        
    velocity.y += gravity * delta * mult;
    velocity.y = clamp(velocity.y, player_movement.jump_force, player_movement.max_fall_speed)

func _physics_process(delta):
    _update_timers()
    
    if is_on_floor():
        player_movement.has_double_jump = true;
    
    var current_state = state_machine.current_state as PlayerState;
    if current_state and current_state.can_move:
        move_and_slide()

func _handle_animation():
     #Don't change animation when player died, because it doesn't have health bar
    if died:
        return
    
    if player_movement.direction < 0:
        sprite.flip_h = true
    elif player_movement.direction > 0:
        sprite.flip_h = false

func _died():
    if died:
        return
    died = true
    # TODO: This is part of die state
    camera.apply_shake()
    state_machine.switch_state(died_state)
    velocity = Vector2(0, -400);
    var tween = create_tween()
    tween.tween_property(sprite, "rotation", [-10, 10][randi() % 2], 4)
    get_node("CollisionShape2D").set_deferred("disabled", true)
    await get_tree().create_timer(1).timeout
    tween.kill()
    
    if Checkpoint.last_checkpoint:
        died = false;
        position = Checkpoint.last_checkpoint.position;
        get_node("CollisionShape2D").set_deferred("disabled", false)
        sprite.rotation = 0
        state_machine.switch_state(appearing_state)
    else:
        SceneManager.reload_scene()
    
    
    
func _update_timers() -> void:
    if is_on_floor():
        player_movement.cayote_timer = player_movement.cayote_time
    
func _handle_jump() -> bool:
    if player_movement.cayote_timer > 0 and player_movement.jump_buffer_timer > 0:
        velocity.y = player_movement.jump_force;
        player_movement.cayote_timer = 0
        player_movement.jump_buffer_timer = 0
        state_machine.switch_state(jump_state)
        
        return true;
        
    return false;

func _handle_double_jump() -> bool:
    if not player_movement.has_double_jump:
        return false
        
    player_movement.has_double_jump = false;
    velocity.y = player_movement.double_jump_force
    state_machine.switch_state(double_jump_state)
    return true;

func _reached_cup() -> void:
    state_machine.switch_state(disappearing_state)
