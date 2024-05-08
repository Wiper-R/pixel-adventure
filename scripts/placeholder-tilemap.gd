extends TileMap

const START_SCENE = preload ("res://scenes/checkpoints/start.tscn")
const CHECKPOINT_SCENE = preload ("res://scenes/checkpoints/checkpoint.tscn")
const END_SCENE = preload ("res://scenes/checkpoints/end.tscn")

const START_TILE = 0
const CHECKPOINT_TILE = 1
const END_TILE = 2

func _ready() -> void:
	for layer_idx in range(get_layers_count()):
		var used_cells = get_used_cells(layer_idx)
		for cell in used_cells:
			instantiate_scene_at_cell(layer_idx, cell)
			
func get_scene_for_tile(tile_id) -> PackedScene:
	match tile_id:
		START_TILE:
			return START_SCENE
		CHECKPOINT_TILE:
			return CHECKPOINT_SCENE
		END_TILE:
			return END_SCENE
		_:
			return null # No match found, return null

func instantiate_scene_at_cell(layer_idx: int, cell: Vector2i) -> void:
	var tile_id = get_cell_source_id(layer_idx, cell)
	var object_scene = get_scene_for_tile(tile_id)
	var tiledata = get_cell_tile_data(layer_idx, cell)
	if not object_scene:
		var tile_name = tile_set.get_source(tile_id).resource_name
		var error_message = "Scene not found:\n
			Tile ID: {tile_id}
			Tile Name: {tile_name}
			".format({"tile_id": tile_id, "tile_name": tile_name})
		push_error(error_message)
		return
		
	var object_instance = object_scene.instantiate()
	set_cell(layer_idx, cell, -1)
	object_instance.position = map_to_local(cell) * scale
	object_instance.position -= Vector2(tiledata.texture_origin);
	add_child(object_instance)
