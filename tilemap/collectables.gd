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
            var fruit = fruit_scene.instantiate()
            fruit.fruit_type = Fruits[tile_id]
            TilemapUtils.instantiate_scene_at_cell(self, layer_idx, cell, fruit)
