extends Node
class_name StateMachine


@export var default_state: State;
var current_state: State;
var current_state_name: String;
var states: Dictionary = {};

@export var debug_state_label: Label;


func _ready() -> void:        
    for state in get_children():
        if state is State:
            states[state.name.to_lower()] = state
    _machine_ready();
    switch_state(default_state)

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
        current_state.call_deferred("on_exit")
        current_state.next_state = null;
        
    if state:
        state.call_deferred("on_enter")
    
    current_state_name = name.to_lower()
    current_state = state

func switch_state_str(state: String):
    state = state.to_lower()
    var _state: State = states[state.to_lower()]
    if not _state:
        push_error("Improper state is passed: %s" % state);
        return
        
    switch_state(_state)

func _machine_ready() -> void:
    pass
