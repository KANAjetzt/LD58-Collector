class_name ComponentJobPickUpBatteryFull
extends Node


signal completed


@export var resource: DataResource


func start() -> void:
	var parent = get_parent()

	if parent is not ComponentJobContainer:
		push_error("Jobs have to be inside a JobContainer!")
		return

	var unit: Unit = parent.unit
	var target: Target = unit.get("target") if is_instance_valid(unit.get("target")) else null
	var building: Building = target.get("parent") if target else null

	# Check if building can handle pick up
	if building and building.get("pick_up_manager"):
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
			and storage.get_first_full()
		):
			return storage

	return null
