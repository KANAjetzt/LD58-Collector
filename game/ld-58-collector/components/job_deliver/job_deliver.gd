class_name ComponentJobDeliver
extends Node


signal completed


@export var resource: DataResource


func start() -> void:
	var parent = get_parent()

	if parent is not ComponentJobContainer:
		push_error("Jobs have to be inside a JobContainer!")
		return

	var unit: Unit = parent.unit
	var building: Building = unit.target.parent
	var result := 0.0

	if building.deliver_manager:
		result = unit.pick_up_manager.request(resource)
		if result > 0.0:
			building.deliver_manager.request(resource)

	completed.emit()
