extends StateMachine

class_name PlayerStateMachine;

@export var parent: Player;
@export var animation_player: AnimationPlayer;


# TODO: Bring move_and_slide here?

func _machine_ready() -> void:
    for state in get_children():
        if state is PlayerState:
            state.parent = parent;
            state.animation_player = animation_player;
