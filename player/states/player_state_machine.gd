extends StateMachine

@export var debug_state_label: Label;
@export var animation_tree: AnimationTree;

func _process(delta: float) -> void:
    super(delta)
    debug_state_label.text = "State: %s" % current_state.name;
    
func _ready() -> void:
    for state in get_children():
        if state is PlayerState:
            state.playback = animation_tree.get("parameters/playback")
