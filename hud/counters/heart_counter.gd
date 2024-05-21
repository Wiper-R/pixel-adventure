extends NinePatchRect

@onready var label: Label = $Label

func _init() -> void:
    Events.PLAYER_LIVES_UPDATED.connect(_update_label)
    
    
func _update_label(lives: int) -> void:
    label.text = "x%s" % lives;
    
