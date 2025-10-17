class_name ComponentTileMapHoverPreview
extends Node


signal cell_changed(map_cords: Vector2i, world_cords: Vector2)


@export var tile_map: TileMapLayer :
	set(new_value):
		tile_map = new_value
		tile_set = tile_map.tile_set
@export var custom_mouse_cursor: Texture
## Center of 32x32 image
@export var custom_image_hotspot := Vector2(16, 16)
@export var tile_map_placeable: TileMapLayer

var tile_set: TileSet
var last_cell: Vector2i


func _ready() -> void:
	if custom_mouse_cursor:
		Input.set_custom_mouse_cursor(custom_mouse_cursor, Input.CURSOR_ARROW, custom_image_hotspot)


func _process(_delta: float) -> void:
	var map_cords := tile_map.local_to_map(tile_map.get_local_mouse_position())
	var world_cords := tile_map_placeable.to_global(tile_map.map_to_local(map_cords))
	var tile_id := tile_map.get_cell_source_id(map_cords)

	if tile_id == 0:
		return

	# clear last_cell
	tile_map.set_cell(last_cell)

	last_cell = map_cords
	tile_map.set_cell(map_cords, 0, Vector2i(0, 0), 0)

	cell_changed.emit(map_cords, world_cords)
