class_name ComponentJobDeliverBatteryFull
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

	# Check if building can handle deliveries
	if building and building.get("deliver_manager"):
		# Request pick up from unit store
		var unit_storage := unit.pick_up_manager.request(resource)
		# If resource available
		if unit_storage:
			# Request delivery
			var building_storage := building.deliver_manager.request(resource, null, get_first_empty_battery)
			if building_storage:
				unit.pick_up_manager.pick_up(unit_storage)
				building.deliver_manager.deliver(building_storage)

	completed.emit()


func get_first_empty_battery(storages: Array[ComponentStorage], requested_resource: DataResource, _requested_sub_resource: DataResource) -> ComponentStorage:
	for storage in storages:
		# If there is an empty battery reset it to full energy
		if (
			storage.resource == requested_resource
			and storage is ContainerStorage
			and storage.get_first_empty()
		):
			var storage_battery_empty: ComponentStorage = storage.get_first_empty()
			storage_battery_empty.current = storage_battery_empty.maximum
			return null
		# If there is still space for batteries deliver the new one
		if (
			storage.resource == requested_resource
			and storage is ContainerStorage
			and storage.current < storage.maximum
		):
			# Uh Oh - it's late so it's ok ಠ_ಠ
			var storage_battery: ComponentStorage = storage.get_child(int(storage.current)).storage
			storage_battery.current = storage_battery.maximum
			return storage

	return null
