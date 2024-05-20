extends TextureRect
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _play_break() -> void:
    animation_player.play("break")
