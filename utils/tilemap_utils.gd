class_name TilemapUtils;

static func instantiate_scene_at_cell(tilemap: TileMap, layer_idx: int, cell: Vector2i, object: Node2D) -> void:
    var tile_id = tilemap.get_cell_source_id(layer_idx, cell)
    var tiledata = tilemap.get_cell_tile_data(layer_idx, cell)
    
    # Set the cell to be empty
    tilemap.set_cell(layer_idx, cell, -1)
    
    # Calculate the position
    object.position = tilemap.map_to_local(cell) * tilemap.scale
    object.position -= Vector2(tiledata.texture_origin)
    
    # Add the object to the tilemap
    tilemap.add_child(object)
