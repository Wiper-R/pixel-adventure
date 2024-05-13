extends CharacterBody2D

class_name Player

@export var movement_speed = 250.0
@export var jump_force = -350
@export var jump_buffer_time: float = 0.1;
@export var cayote_time: float = 0.25;
@export var gravity_multiplier: float = 1;
@export var fall_multiplier: float = 1.2;
@export var max_fall_speed: float = 40;

@onready var animation_player = $AnimationPlayer
@onready var jump_particles = %JumpParticles
@onready var run_particles = %RunParticles
@onready var sprite: Sprite2D = $Sprite2D
@onready var animation_tree: AnimationTree = $AnimationTree

var jump_buffer_timer = 0;
var cayote_timer: float = 0;
var died: bool = false;
var direction: int = 0;


# FIXME: Fix Controller Axis movement

#region Sounds
@onready var jump_sound = $Sounds/Jump
#endregion

# TODO: Handle dying properly

func _ready():
    animation_tree.active = true;
    randomize()
    add_to_group(Groups.PLAYER)
    Events.PLAYER_DIED.connect(_died)
    

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _handle_timers(delta: float):
    jump_buffer_timer -= delta
    cayote_timer -= delta
    
func _handle_jump():
    if died:
        return
        
    if (jump_buffer_timer > 0) and (is_on_floor() or cayote_timer > 0):
        cayote_timer = 0
        velocity.y = jump_force
        jump_sound.play()
        jump_particles.emitting = true
        
func _apply_gravity(delta: float):
    if is_on_floor():
        return
        
    var mult = gravity_multiplier;
    
    if velocity.y > 0:
        mult *= fall_multiplier;
        
    velocity.y += gravity * delta * mult;
    velocity.y = clamp(velocity.y, jump_force, max_fall_speed)
    
func _reset_timers():
    if is_on_floor():
        cayote_timer = cayote_time;
        
    if Input.is_action_just_pressed("jump"):
        jump_buffer_timer = jump_buffer_time

func _handle_input():
    #var raw_dir = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
    var raw_dir = Input.get_axis("move_left", "move_right")
    direction = sign(raw_dir) * ceil(abs(raw_dir))

func _process(delta: float):
    _handle_timers(delta)
    _handle_jump()
    _reset_timers()
    _handle_input()
    _handle_animation()
    
func _handle_movement():
    if died:
        return
        
    if direction:
        velocity.x = direction * movement_speed
    else:
        velocity.x = move_toward(velocity.x, 0, movement_speed)

func _physics_process(delta):
    _apply_gravity(delta)
    _handle_movement()
    move_and_slide()

func _handle_animation():
    # Don't change animation when player died, because it doesn't have health bar
    #if died:
        #return
        #
    #if is_on_floor():
        #if abs(velocity.x) > 0:
            #animation_player.play("run")
        #else:
            #animation_player.play("idle")
    #else:
        #if velocity.y < 0:
            #animation_player.play('jump')
        #elif velocity.y > 0:
            #animation_player.play("fall")
    animation_tree.set("parameters/Move/blend_position", direction)
    
    if direction < 0:
        sprite.flip_h = true
    elif direction > 0:
        sprite.flip_h = false

func _died():
    if died:
        return
    died = true
    animation_player.play("hit")
    velocity = Vector2(0, -400);
    var tween = create_tween()
    tween.tween_property(sprite, "rotation", [-10, 10][randi() % 2], 4)
    get_node("CollisionShape2D").queue_free()
    await get_tree().create_timer(1).timeout
    await SceneManager.reload_scene()

func _emit_run_particles() -> void:
    if abs(velocity.x) > 0 and is_on_floor():
        run_particles.emitting = true
