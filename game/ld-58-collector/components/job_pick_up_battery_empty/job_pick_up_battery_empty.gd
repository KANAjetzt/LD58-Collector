class_name ComponentJobPickUpBatteryEmpty
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
		var building_storage := building.pick_up_manager.request(resource, null, get_first_empty_battery)
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


func get_first_empty_battery(storages: Array[ComponentStorage], requested_resource: DataResource, _requested_sub_resource: DataResource) -> ComponentStorage:
	for storage in storages:
		if (
			storage.resource == requested_resource
			and storage.current > 0
			and storage is ContainerStorage
			and storage.get_first_empty()
		):
			return storage

	return null
