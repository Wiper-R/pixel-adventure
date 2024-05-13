extends CharacterBody2D

class_name Player

@export var movement_speed = 250.0
@export var state_machine: StateMachine;

@onready var animation_player = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@onready var animation_tree: AnimationTree = $AnimationTree

var died: bool = false;
var direction: int = 0;

# TODO: Handle dying properly



func _ready():
    animation_tree.active = true;
    add_to_group(Groups.PLAYER)
    Events.PLAYER_DIED.connect(_died)


func _handle_input():
    var raw_dir = Input.get_axis("move_left", "move_right")
    if raw_dir > 0:
        direction = 1
    elif raw_dir < 0:
        direction = -1
    else:
        direction = 0;

func _process(delta: float):
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
    _handle_movement()
    move_and_slide()

func _handle_animation():
     #Don't change animation when player died, because it doesn't have health bar
    if died:
        return
        
    animation_tree.set("parameters/move/blend_position", direction)
    
    if direction < 0:
        sprite.flip_h = true
    elif direction > 0:
        sprite.flip_h = false

func _died():
    if died:
        return
    died = true
    animation_tree.get("parameters/playback").travel("hit")
    velocity = Vector2(0, -400);
    var tween = create_tween()
    tween.tween_property(sprite, "rotation", [-10, 10][randi() % 2], 4)
    get_node("CollisionShape2D").queue_free()
    await get_tree().create_timer(1).timeout
    await SceneManager.reload_scene()
