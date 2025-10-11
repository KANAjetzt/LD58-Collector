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
	var target: Target = unit.get("target") if is_instance_valid(unit.get("target")) else null
	var building: Building = target.get("parent") if target else null
	var building_deliver_manager: ComponentManagerDeliver = building.get("deliver_manager") if building else null
	var unit_storage: ComponentStorage
	var unit_sub_storage: ComponentStorage
	var building_storage: ComponentStorage
	var building_sub_storage: ComponentStorage

	# If building can handle deliveries
	if building_deliver_manager:
		# Request pick up from unit storage
		unit_storage = unit.pick_up_manager.request(resource)
		# If sub resource also request sub resource from unit storage
		if unit_storage and resource.sub_resource:
			unit_sub_storage = unit.pick_up_manager.request_sub_resource(unit_storage, resource.sub_resource)

		# If requested resource in unit storage
		if unit_storage:
			# Request delivery to building
			building_storage = building.deliver_manager.request(resource)
			# If storage space available deliver base resource
			if building_storage:
				# Pick it up from the units storage
				unit.pick_up_manager.pick_up(unit_storage)
				# Deliver it to the building storage
				building.deliver_manager.deliver(building_storage)
			# If sub resource available
			if building_storage and unit_sub_storage:
				# Request sub resource delivery to building storage
				building_sub_storage = building_deliver_manager.request_sub_resource(building_storage, resource.sub_resource)
			# If sub resource storage space available
			if building_sub_storage:
				# Pick it up from the units storage
				var amount := unit.pick_up_manager.pick_up(unit_sub_storage, unit_sub_storage.current)
				# Deliver it to the building storage
				building.deliver_manager.deliver(building_sub_storage, amount)

	completed.emit()
