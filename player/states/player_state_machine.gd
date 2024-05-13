extends StateMachine

class_name PlayerStateMachine;

@export var parent: Player;
@export var animation_tree: AnimationTree;


# TODO: Bring move_and_slide here?

func ready() -> void:
    for state in get_children():
        if state is PlayerState:
            state.parent = parent;
            state.playback = animation_tree.get("parameters/playback")
