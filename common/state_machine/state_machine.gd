extends Node
class_name StateMachine

@export var current_state: State;

func _process(delta: float) -> void:
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
