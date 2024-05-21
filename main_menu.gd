extends CanvasLayer

const LEVEL_1 = preload("res://levels/level_1/level_1.tscn")

func _enter_tree() -> void:
    get_window().content_scale_mode = Window.CONTENT_SCALE_MODE_CANVAS_ITEMS

func _on_play_pressed() -> void:
    SceneManager.change_scene(LEVEL_1, SceneManager.Transition.BARS)

func _on_quit_pressed() -> void:
    get_tree().quit()
