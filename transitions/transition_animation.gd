extends CanvasLayer
class_name TransitionAnimation;

@export var animation_player: AnimationPlayer;
@export var transition_in: String = "animate_in";
@export var transition_out: String = "animate_out";

func _transition_in():
    animation_player.play(transition_in)
    return animation_player.animation_finished
    
func _transition_out():
    animation_player.play(transition_out)
    return animation_player.animation_finished

