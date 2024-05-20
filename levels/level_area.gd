extends Node2D
class_name LevelArea;
@onready var camera: ExtendedCamera2D = $ExtendedCamera2D
@export var player_spawn: Marker2D;

func _ready() -> void:
    Events.RESET_PLAYER_POSITION.emit()
