extends Node

var player: Player = null;

func _ready():
    Events.PLAYER_DIED.connect(_on_player_died)
    Events.PLAYER_TOUCHED_CUP.connect(_touched_cup)
    
func _on_player_died():
    if not player.can_die():
        return
        
    player.lives -= 1


func handle_player_death() -> void:
    if player.lives > 0:
        await SceneManager.fade_transition._transition_in()
        player.global_position = get_tree().get_first_node_in_group(Groups.PLAYER_SPAWN_POSITION).global_position;
        await get_tree().physics_frame
        await get_tree().physics_frame
        player.rebirth()
        player.state_machine.switch_state_str("fall")
        await SceneManager.fade_transition._transition_out()
    else:
        SceneManager.reload_scene()


func _touched_cup(next_level_scene: PackedScene) -> void:
    if not next_level_scene:
        return;
    await Events.PLAYER_FINISHED_DISAPPEARING;
    SceneManager.change_scene(next_level_scene, SceneManager.Transition.BARS)
