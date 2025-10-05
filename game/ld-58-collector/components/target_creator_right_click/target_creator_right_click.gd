class_name ComponentTargetCreatorRightClick
extends Node2D


@export var target_scene: PackedScene
@export var target_parent: Node


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("action") and Global.units_selected.size() > 0:
		var unit: UnitDrone = Global.units_selected.keys()[0]

		var params := PhysicsPointQueryParameters2D.new()
		params.collide_with_areas = true
		params.position = get_global_mouse_position()
		var result := get_world_2d().direct_space_state.intersect_point(params)

		if result.size() == 0:
			var new_target: Target = target_scene.instantiate()
			new_target.global_position = get_global_mouse_position()
			if target_parent.get_child_count() > 0:
				target_parent.get_child(0).clear()
			target_parent.add_child(new_target)
			new_target.unit_entered.connect(
				func _on_unit_entered(_unit: Unit) -> void:
					new_target.clear()
			)
			unit.target = new_target
			unit.job_manager.stop()
		else:
			var building: Building = result[0].collider.parent
			unit.target = building.activate_target()
			print("=== BUILDING SELECTED ===")
