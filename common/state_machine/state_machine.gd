extends Node
class_name StateMachine


@export var default_state: State;
var current_state: State;

@export var debug_state_label: Label;


func _ready() -> void:
    current_state = default_state;
    ready();

func _process(delta: float) -> void:
    if debug_state_label:
        debug_state_label.text = current_state.name;
        
    current_state.state_process(delta)
        
func _input(event: InputEvent) -> void:
    current_state.state_input(event)
    
func _physics_process(delta: float) -> void:
    current_state.state_physics_process(delta)
    
    if current_state.next_state:
        current_state.on_exit()
        switch_state(current_state.next_state)
        current_state.next_state = null;
        
func switch_state(state: State):
    state.on_enter()
    current_state = state

func ready() -> void:
    pass
