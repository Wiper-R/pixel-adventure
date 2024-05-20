extends Marker2D


func _enter_tree() -> void:
    add_to_group(Groups.PLAYER_SPAWN_POSITION)


func _exit_tree() -> void:
    remove_from_group(Groups.PLAYER_SPAWN_POSITION)
