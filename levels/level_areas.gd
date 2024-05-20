extends Node2D
const FADE_TRANSITION = preload("res://transitions/fade_transition.tscn")
var _areas: Array = []

var _current_area = -1;

func _disable_area(idx: int) -> void:
    var area: LevelArea = _areas[idx]
    area.disable()
    
func _enable_area(idx: int) -> void:
    var area: LevelArea = _areas[idx]
    area.enable()

func _ready() -> void:
    Events.LOAD_NEXT_AREA.connect(_laod_next_area)
    for child in get_children():
        if child is LevelArea:
            _areas.append(child)
            
    for idx in _areas.size():
        _disable_area(idx)
            
            
    _laod_next_area()


func _laod_next_area() -> void:
    var transition: TransitionAnimation;
    if _current_area >= 0:
        transition = FADE_TRANSITION.instantiate()
        add_child(transition)
        await transition._transition_in()
    if _current_area >= 0:
        _disable_area(_current_area)
        
    var next_area = _current_area + 1
    _enable_area(next_area)
    if _current_area  >= 0:
        await transition._transition_out()
        remove_child(transition)
    _current_area = next_area

