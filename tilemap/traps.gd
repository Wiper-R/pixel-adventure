extends TileMap

@export var SPIKE_SCENE: PackedScene;

#@export var fruit_scene: PackedScene;


# TileId: PackedScene
@onready var Traps = {
    0: SPIKE_SCENE
}


func _ready() -> void:
    for layer_idx in range(get_layers_count()):
        var used_cells = get_used_cells(layer_idx)
        for cell in used_cells:
            var tile_id = get_cell_source_id(layer_idx, cell)
            var object_scene = Traps[tile_id]
            var object = object_scene.instantiate()
            TilemapUtils.instantiate_scene_at_cell(self, layer_idx, cell, object)
