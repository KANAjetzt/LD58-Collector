class_name ComponentTileMapPlacer
extends Node


@export var tile_map: TileMapLayer


func _process(_delta: float) -> void:
	var map_cords := tile_map.local_to_map(tile_map.get_local_mouse_position())
	var cell_id := tile_map.get_cell_source_id(map_cords)

	if Input.is_action_just_pressed("select") and not cell_id == 0:
		tile_map.set_cell(map_cords, 0, Vector2i(0, 0), 0)
