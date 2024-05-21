extends ColorRect
const MAIN_MENU = preload("res://main_menu.tscn")

func _enter_tree() -> void:
    get_window().content_scale_mode = Window.CONTENT_SCALE_MODE_DISABLED

func _ready() -> void:
    await SceneManager.fade_transition._transition_out()
    await get_tree().create_timer(2).timeout
    # Transition to other scene
    await SceneManager.change_scene(MAIN_MENU, SceneManager.Transition.FADE)
