extends Node
class_name PlayerMovement;

var direction = 0;

@export_group("Jump")
@export var jump_force: float = -400;
@export var cayote_time: float = 0.25;
@export var jump_buffer_time: float = 0.1;
@export var double_jump_force: float = -200;

var jump_buffer_timer: float = 0;
var cayote_timer: float = 0;
var has_double_jump: bool = false;


@export_group("Fall")
@export var gravity_mutiplier: float = 1;
@export var fall_multiplier: float = 2.5;
@export var max_fall_speed: float = 400;


func _process(delta: float) -> void:
    if Input.is_action_just_pressed("jump"):
        jump_buffer_timer = jump_buffer_time
        get_viewport().set_input_as_handled()
        
    #if Input.is_action_just_released("jump"):
        #jump_buffer_timer = 0
        
    jump_buffer_timer -= delta
    cayote_timer -= delta
