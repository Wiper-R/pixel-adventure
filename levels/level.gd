extends Node
class_name Level;


@export var player: Player;
var current_area: LevelArea = null;
var is_ready = false;
const FADE_TRANSITION = preload("res://transitions/fade_transition.tscn")


func _ready() -> void:
    is_ready = true;
    assert(player, "Player is not set")            
    for child in get_children():
        if child is LevelArea:
            current_area = child;
            break;
            
    assert(current_area, "Can't find LevelArea in level")
    _reset_player_position(current_area.player_spawn.global_position)
    Events.LOAD_NEXT_AREA.connect(_load_next_area)
    

func _load_next_area(next_area_scene: PackedScene) -> void:
    var transition: TransitionAnimation = FADE_TRANSITION.instantiate()
    get_tree().get_root().add_child(transition)
    await transition._transition_in()
    
    if is_instance_valid(current_area):
        current_area.queue_free()
        
    current_area = next_area_scene.instantiate()
    _reset_player_position(current_area.player_spawn.global_position);
    add_child(current_area)
    await transition._transition_out()
    get_tree().get_root().remove_child(transition)
    player.state_machine.switch_state_str("idle")
        
#region Event Handlers   
func _reset_player_position(spawn_position: Vector2) -> void:
    player.global_position = spawn_position;
    #Events.PLAYER_POSITION_RESET_DONE.emit()
    
#func _touched_checkpoint() -> void:
    #player.state_machine.switch_state_str("idle")
#endregion

