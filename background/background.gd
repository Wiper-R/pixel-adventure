extends ParallaxBackground

@export var speed = 20;
var _offset = Vector2.ZERO;


# Called when the node enters the scene tree for the first time.
func _ready():
    visible = true;
    for group in get_groups():
        if group.begins_with("__cameras"):
            remove_from_group(group)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    _offset += speed * Vector2.DOWN * delta;
    scroll_base_offset = _offset;

