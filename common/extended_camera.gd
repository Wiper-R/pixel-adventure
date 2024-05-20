extends Camera2D

class_name ExtendedCamera2D;

@export var random_shake: float = 20;
@export var shake_fade: float = 10;
var shake_strength: float = 0;

var rng = RandomNumberGenerator.new()

func random_offset() -> Vector2:
    return Vector2(rng.randf_range(-shake_strength, shake_strength), rng.randf_range(-shake_strength, shake_strength))

func _process(delta: float) -> void:        
    if shake_strength > 0:
        shake_strength = lerpf(shake_strength, 0, shake_fade * delta)
        offset = random_offset()
        
func apply_shake() -> void:
    shake_strength = random_shake;
