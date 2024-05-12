extends Node2D

const CONFETTI = preload("res://scenes/particles/confetti.tscn")

const COLORS = [
	'6cd9f1', # Light Blue
	'a4cc42', # Lime Green
	'f7ec8a', # Pale Yellow
	'f18b72', # Salmon Pink
	'f89cc0', # Light Pink
	'f2bc7e'  # Peach
];

signal confetti;

# Called from parent
func _confetti():
	for confetti in get_children() as Array[CPUParticles2D]:
		confetti.emitting = true
	

func _ready() -> void:
	confetti.connect(_confetti)
	for color in COLORS:
		var object = CONFETTI.instantiate()
		object.color = Color(str(color))
		add_child(object)

