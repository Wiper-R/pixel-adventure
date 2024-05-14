extends Node2D
@onready var scene_transition: CanvasLayer = $SceneTransition
var duration = 0.1;
var min_scale = Vector2.ONE * 0.4;

func _ready() -> void:
    for container in scene_transition.get_children():
        container.scale = Vector2.ZERO;
        container.modulate = Color(container.modulate, 0)

func _animate_in() -> void:
    var tween = create_tween()
    tween.set_ease(Tween.EASE_IN_OUT)
    tween.set_trans(Tween.TRANS_SPRING)
    for container in scene_transition.get_children(): 
        container.scale = min_scale;
        container.modulate = Color(container.modulate, 0)
        tween.tween_interval(duration)
        tween.set_parallel()   
        tween.tween_property(container, "scale", Vector2.ONE, duration)
        tween.tween_property(container, "modulate", Color(container.modulate, 1), duration)
        tween.set_parallel(false)
            
    await tween.finished
    
func _animate_out() -> void:
    var tween = create_tween()
    tween.set_trans(Tween.TRANS_LINEAR)
    tween.set_ease(Tween.EASE_IN_OUT)
    for container in scene_transition.get_children():
        container.scale = Vector2.ONE
        container.modulate = Color(container.modulate, 1)
        tween.tween_interval(duration)
        tween.set_parallel()
        tween.tween_property(container, "scale", min_scale, duration)
        tween.tween_property(container, "modulate", Color(container.modulate, 0), duration)
        tween.set_parallel(false)
        
    await tween.finished


func change_scene(scene: PackedScene) -> void:
    await _animate_in()
    get_tree().change_scene_to_packed(scene)
    await _animate_out()
    
func reload_scene() -> void:
    await _animate_in()
    get_tree().reload_current_scene()
    get_tree().paused = true;
    await _animate_out()
    get_tree().paused = false;
    

#func _ready() -> void:
    #pass
    #get_tree().paused = true
    #await _animate_out()
    #get_tree().paused = false
