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
@onready var jump_particles = $JumpParticles
@onready var run_particles = $RunParticles
var jump_buffer_timer = 0;
var cayote_timer: float = 0;

#region Sounds
@onready var jump_sound = $Sounds/Jump
#endregion

func _ready():
	add_to_group("player")

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _process(delta: float):
	if (jump_buffer_timer > 0)&&(is_on_floor()||cayote_timer > 0):
		cayote_timer = 0
		velocity.y = jump_force
		jump_sound.play()
		jump_particles.emitting = true
		
	jump_buffer_timer -= delta
	cayote_timer -= delta

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		var mult = gravity_multiplier;
		
		if velocity.y > 0:
			mult *= fall_multiplier;
			
		velocity.y += gravity * delta * mult;
		
		velocity.y = clamp(velocity.y, jump_force, max_fall_speed)
		
	if is_on_floor():
		cayote_timer = cayote_time

	# Handle jump.
	if Input.is_action_just_pressed("jump"):
		jump_buffer_timer = jump_buffer_time

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	
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
	if direction:
		velocity.x = direction * movement_speed
	else:
		velocity.x = move_toward(velocity.x, 0, movement_speed)

	move_and_slide()
