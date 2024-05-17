extends CanvasLayer
class_name SceneTransition

@export var animation_player: AnimationPlayer;
@export var transition_in: String = "animate_in";
@export var transition_out: String = "animate_out";
@onready var container: VBoxContainer = $VBoxContainer

func _transition_in():
    animation_player.play(transition_in)
    return animation_player.animation_finished
    
func _transition_out():
    animation_player.play(transition_out)
    return animation_player.animation_finished


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
    print(anim_name)
