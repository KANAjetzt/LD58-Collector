class_name ComponentJobPickUp
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

	# Check if building can handle pick up
	if building.pick_up_manager:
		# Request pick up from building
		var building_storage := building.pick_up_manager.request(resource)
		# If resource available
		if building_storage:
			# Rquest delivery to unit
			var unit_storage := unit.deliver_manager.request(resource)
			# If space availabel on unit storage
			if unit_storage:
				# Pick up resource from building
				building.pick_up_manager.pick_up(building_storage)
				# Deliver to unit
				unit.deliver_manager.deliver(unit_storage)

	completed.emit()
