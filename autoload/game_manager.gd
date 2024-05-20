extends Node

var player: Player = null;

func _ready():
    Events.PLAYER_DIED.connect(_on_player_died)
    
func _on_player_died():
    if player && player.died:
        return
        
    player.lives -= 1


func handle_player_death() -> void:
    if player.lives > 0:
        await SceneManager.fade_transition._transition_in()
        player.global_position = get_tree().get_first_node_in_group(Groups.PLAYER_SPAWN_POSITION).global_position;
        player.rebirth()
        player.state_machine.switch_state_str("fall")
        await SceneManager.fade_transition._transition_out()
    else:
        SceneManager.reload_scene()
