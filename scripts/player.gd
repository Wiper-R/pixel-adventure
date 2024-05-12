extends CharacterBody2D

class_name Player

@export var movement_speed = 250.0
@export var jump_force = -350
@export var jump_buffer_time: float = 0.1;
@export var cayote_time: float = 0.25;
@export var gravity_multiplier: float = 1;
@export var fall_multiplier: float = 1.2;
@export var max_fall_speed: float = 40;

@onready var animated_sprite = $AnimatedSprite2D
@onready var jump_particles = %JumpParticles
@onready var run_particles = %RunParticles

var jump_buffer_timer = 0;
var cayote_timer: float = 0;
var died: bool = false;
var direction: int = 0;


#region Sounds
@onready var jump_sound = $Sounds/Jump
#endregion

# TODO: Handle dying properly

func _ready():
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
        
    if (jump_buffer_timer > 0)&&(is_on_floor()||cayote_timer > 0):
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
    direction = Input.get_axis("move_left", "move_right")

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
    if died:
        return
        
    if is_on_floor():
        if abs(velocity.x) > 0:
            animated_sprite.play("run")
        else:
            animated_sprite.play("idle")
    else:
        if velocity.y < 0:
            animated_sprite.play('jump')
        elif velocity.y > 0:
            animated_sprite.play("fall")
    
    if direction < 0:
        animated_sprite.flip_h = true
    elif direction > 0:
        animated_sprite.flip_h = false

func _died():
    if died:
        return
    died = true
    animated_sprite.play("hit")
    velocity = Vector2(0, -400);
    var tween = create_tween()
    tween.tween_property(animated_sprite, "rotation", [-10, 10][randi() % 2], 4)
    get_node("CollisionShape2D").queue_free()
    await get_tree().create_timer(2).timeout
    await get_tree().reload_current_scene()

func _emit_run_particles() -> void:
    if abs(velocity.x) > 0 and is_on_floor():
        run_particles.emitting = true
