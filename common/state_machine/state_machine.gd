extends Node
class_name StateMachine


@export var default_state: State;
var current_state: State;

@export var debug_state_label: Label;


func _ready() -> void:
    current_state = default_state;
    ready();
    
    if not current_state:
        return
        
    current_state.call_deferred("on_enter")

func _process(delta: float) -> void:
    if not current_state:
        return
        
    if debug_state_label != null:
        debug_state_label.text = current_state.name;
        
    current_state.state_process(delta)
        
func _input(event: InputEvent) -> void:
    if not current_state:
        return
        
    current_state.state_input(event)
    
func _physics_process(delta: float) -> void:
    if not current_state:
        return
        
    current_state.state_physics_process(delta)
    
    if current_state.next_state:
        switch_state(current_state.next_state)
        
func switch_state(state: State):
    if current_state:
        current_state.on_exit()
        current_state.next_state = null;
    if state:
        state.on_enter()
    current_state = state

func ready() -> void:
    pass
