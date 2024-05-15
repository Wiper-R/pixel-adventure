extends TileMap

@export var SPIKE_SCENE: PackedScene;

#@export var fruit_scene: PackedScene;

const SPIKE_TILE_ID = 0;

# TileId: PackedScene
@onready var Traps = {
    SPIKE_TILE_ID: SPIKE_SCENE
}

# TIleID: {alternative tile id: direction}
const SPIKE_TRAP_ORIENTATION = {
        0: Vector2.UP, # Up Facing
        3: Vector2.LEFT, # Left Facing
        4: Vector2.RIGHT, # Right Facing
        5: Vector2.DOWN, # Down Facing
}




func _ready() -> void:
    for layer in range(get_layers_count()):
        var used_cells = get_used_cells(layer)
        for cell in used_cells:
            var tile_id = get_cell_source_id(layer, cell)
            var tiledata = get_cell_tile_data(layer, cell)
            var object_scene = Traps[tile_id]
            if object_scene == SPIKE_SCENE:get_cell_alternative_tile(layer, cell)
            var object = object_scene.instantiate()
            if tile_id == SPIKE_TILE_ID:
                var alternative_tile_id = get_cell_alternative_tile(layer, cell)
                var orient = SPIKE_TRAP_ORIENTATION[alternative_tile_id]
                if orient == Vector2.DOWN:
                    object.scale.y = object.scale.y * -1
                elif orient == Vector2.LEFT:
                    object.rotation_degrees = -90
                elif orient == Vector2.RIGHT:
                    object.rotation_degrees = 90;
                
            
            # Set the cell to be empty
            set_cell(layer, cell, -1)
            
            # Calculate the position
            object.position = map_to_local(cell) * scale
            object.position -= Vector2(tiledata.texture_origin)
    
            add_child(object)
