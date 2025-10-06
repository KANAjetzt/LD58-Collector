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

	# Check if building can handle deliveries
	if building.deliver_manager:
		# Request pick up from unit store
		var unit_storage := unit.pick_up_manager.request(resource)
		# If resource available
		if unit_storage:
			# Request delivery
			var building_storage := building.deliver_manager.request(resource)
			if building_storage:
				unit.pick_up_manager.pick_up(unit_storage)
				building.deliver_manager.deliver(building_storage)

	completed.emit()
