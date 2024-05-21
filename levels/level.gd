extends Node
class_name Level;


@export var player: Player;
var current_area: LevelArea = null;
const FADE_TRANSITION = preload("res://transitions/fade_transition.tscn")

func _enter_tree() -> void:
    #get_window().content_scale_mode = Window.CONTENT_SCALE_MODE_CANVAS_ITEMS
    Events.RESET_PLAYER_POSITION.connect(_reset_player_position)

func _ready() -> void:
               
    for child in get_children():
        if child is LevelArea:
            current_area = child;
            break;
            
            
    assert(player, "Player is not set") 
    assert(current_area, "Can't find LevelArea in level")
    
    Events.LOAD_NEXT_AREA.connect(_load_next_area)
    

func _load_next_area(next_area_scene: PackedScene) -> void:
    var transition: TransitionAnimation = FADE_TRANSITION.instantiate()
    get_tree().get_root().add_child(transition)
    await transition._transition_in()
    
    if is_instance_valid(current_area):
        remove_child(current_area)
        current_area.queue_free()
        
    current_area = next_area_scene.instantiate()
    add_child(current_area)
    await transition._transition_out()
    get_tree().get_root().remove_child(transition)
    player.state_machine.switch_state_str("idle")
        
#region Event Handlers   
func _reset_player_position() -> void:
    player.global_position = get_tree().get_first_node_in_group(Groups.PLAYER_SPAWN_POSITION).global_position;
