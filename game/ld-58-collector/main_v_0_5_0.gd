extends Node


@onready var placeable_16x16: TileMapLayer = $"Placeable-16x16"

var placeable_16x16_map_cords: Vector2i


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("action"):
		var vecs := [
			Vector2i(placeable_16x16_map_cords.x, placeable_16x16_map_cords.y - 1),
			Vector2i(placeable_16x16_map_cords.x + 1, placeable_16x16_map_cords.y - 1),
			Vector2i(placeable_16x16_map_cords.x + 2, placeable_16x16_map_cords.y - 1),
			Vector2i(placeable_16x16_map_cords.x - 1, placeable_16x16_map_cords.y - 1),
			placeable_16x16_map_cords,
			Vector2i(placeable_16x16_map_cords.x + 1, placeable_16x16_map_cords.y),
			Vector2i(placeable_16x16_map_cords.x + 2, placeable_16x16_map_cords.y),
			Vector2i(placeable_16x16_map_cords.x - 1, placeable_16x16_map_cords.y),
			Vector2i(placeable_16x16_map_cords.x, placeable_16x16_map_cords.y + 1),
			Vector2i(placeable_16x16_map_cords.x + 1, placeable_16x16_map_cords.y + 1),
			Vector2i(placeable_16x16_map_cords.x + 2, placeable_16x16_map_cords.y + 1),
			Vector2i(placeable_16x16_map_cords.x - 1, placeable_16x16_map_cords.y + 1),
			Vector2i(placeable_16x16_map_cords.x, placeable_16x16_map_cords.y + 2),
			Vector2i(placeable_16x16_map_cords.x + 1, placeable_16x16_map_cords.y + 2),
			Vector2i(placeable_16x16_map_cords.x + 2, placeable_16x16_map_cords.y + 2),
			Vector2i(placeable_16x16_map_cords.x - 1, placeable_16x16_map_cords.y + 2),
		]

		# Check for existing building blocks
		for vec in vecs:
			if placeable_16x16.get_cell_source_id(vec) == 0:
				print("AAAAALLLLARRRRM!!!!!!")
				return

		# Place building blocks
		placeable_16x16.set_cell(vecs[0], 0, Vector2i(0, 0), 0)
		placeable_16x16.set_cell(vecs[1], 0, Vector2i(0, 0), 0)
		placeable_16x16.set_cell(vecs[2], 0, Vector2i(0, 0), 0)
		placeable_16x16.set_cell(vecs[3], 0, Vector2i(0, 0), 0)

		placeable_16x16.set_cell(vecs[4], 0, Vector2i(0, 0), 0)
		placeable_16x16.set_cell(vecs[5], 0, Vector2i(0, 0), 0)
		placeable_16x16.set_cell(vecs[6], 0, Vector2i(0, 0), 0)
		placeable_16x16.set_cell(vecs[7], 0, Vector2i(0, 0), 0)
		placeable_16x16.set_cell(vecs[8], 0, Vector2i(0, 0), 0)
		placeable_16x16.set_cell(vecs[9], 0, Vector2i(0, 0), 0)
		placeable_16x16.set_cell(vecs[10], 0, Vector2i(0, 0), 0)
		placeable_16x16.set_cell(vecs[11], 0, Vector2i(0, 0), 0)

		placeable_16x16.set_cell(vecs[12], 0, Vector2i(0, 0), 0)
		placeable_16x16.set_cell(vecs[13], 0, Vector2i(0, 0), 0)
		placeable_16x16.set_cell(vecs[14], 0, Vector2i(0, 0), 0)
		placeable_16x16.set_cell(vecs[15], 0, Vector2i(0, 0), 0)

		# Instance building scene
		var drone_factory: BuildingFactoryDrone = load("res://buildings/factory_drone/factory_drone.tscn").instantiate()
		drone_factory.global_position = placeable_16x16.get_global_mouse_position()
		add_child(drone_factory)


func _on_tile_map_hover_preview_cell_changed(map_cords: Vector2i, world_cords: Vector2) -> void:
	print("map_cords:", map_cords)
	print("world_cords: ", world_cords)
	var world_cords_top_left := Vector2(world_cords.x - 8, world_cords.y - 8)
	print("world_cords_top_left: ", world_cords_top_left)

	placeable_16x16_map_cords = placeable_16x16.local_to_map(placeable_16x16.to_local(world_cords_top_left))

	#if Input.is_action_just_pressed("action"):
		#placeable_16x16.set_cell(placeable_16x16_map_cords, 0, Vector2i(0, 0), 0)
		#placeable_16x16.get_neighbor_cell(placeable_16x16_map_cords, TileSet.CELL_NEIGHBOR_BOTTOM_LEFT_SIDE)
