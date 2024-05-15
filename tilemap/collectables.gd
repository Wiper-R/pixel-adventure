extends TileMap

@export var fruit_scene: PackedScene;


# TileId: FruitType
const Fruits = {
    11: Fruit.FruitType.Apple,
    12: Fruit.FruitType.Bananas,
    13: Fruit.FruitType.Cherries,
    15: Fruit.FruitType.Kiwi,
    16: Fruit.FruitType.Melon,
    17: Fruit.FruitType.Orange,
    18: Fruit.FruitType.Pineapple,
    19: Fruit.FruitType.Strawberry
}


func _ready() -> void:
    for layer_idx in range(get_layers_count()):
        var used_cells = get_used_cells(layer_idx)
        for cell in used_cells:
            var tile_id = get_cell_source_id(layer_idx, cell)
            var tiledata = get_cell_tile_data(layer_idx, cell)
            var object = fruit_scene.instantiate()
            object.fruit_type = Fruits[tile_id]
            
            # Set the cell to be empty
            set_cell(layer_idx, cell, -1)
            
            # Calculate the position
            object.position = map_to_local(cell) * scale
            object.position -= Vector2(tiledata.texture_origin)
            
            # Add the object to the tilemap
            add_child(object)
