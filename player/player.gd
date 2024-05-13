extends CharacterBody2D

class_name Player

@export var movement_speed = 250.0
@export var state_machine: StateMachine;
@export var player_movement: PlayerMovement;
@export var jump_state: PlayerJumpState;
@export var died_state: PlayerDiedState;

@onready var animation_player = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@onready var animation_tree: AnimationTree = $AnimationTree


var died: bool = false;
var gravity = ProjectSettings.get("physics/2d/default_gravity")

# TODO: Handle dying properly



func _ready():
    animation_tree.active = true;
    add_to_group(Groups.PLAYER)
    Events.PLAYER_DIED.connect(_died)


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
    move_and_slide()

func _handle_animation():
     #Don't change animation when player died, because it doesn't have health bar
    if died:
        return
        
    animation_tree.set("parameters/move/blend_position", player_movement.direction)
    
    if player_movement.direction < 0:
        sprite.flip_h = true
    elif player_movement.direction > 0:
        sprite.flip_h = false

func _died():
    if died:
        return
    died = true
    state_machine.switch_state(died_state)
    velocity = Vector2(0, -400);
    var tween = create_tween()
    tween.tween_property(sprite, "rotation", [-10, 10][randi() % 2], 4)
    get_node("CollisionShape2D").queue_free()
    await get_tree().create_timer(1).timeout
    await SceneManager.reload_scene()
    
    
func _update_timers() -> void:
    if is_on_floor():
        player_movement.cayote_timer = player_movement.cayote_time
    
func _handle_jump() -> void:
    if player_movement.cayote_timer > 0 and player_movement.jump_buffer_timer > 0:
        velocity.y = player_movement.jump_force;
        player_movement.cayote_timer = 0
        state_machine.current_state.next_state = jump_state;
