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
	var target: Target = unit.get("target") if is_instance_valid(unit.get("target")) else null
	var building: Building = target.get("parent") if target else null

	# Check if building can handle pick up
	if building and building.get("pick_up_manager"):
		# Request pick up from building
		var building_storage := building.pick_up_manager.request(resource)
		# ☞ﾟヮﾟ)☞ LET'S CONTINUE HERE - THE PICKUP IS KIND OF WORKING BUT WE HAVE TO REMOVE ☜ﾟヮﾟ☜)
		# ☞ﾟヮﾟ)☞ THE BASE RESOURCE AND CAN'T JUST DELIVER THE SUBRESOURCE 					☜ﾟヮﾟ☜)
		# ☞ﾟヮﾟ)☞ WE ALSO NEED TO REMOVE THE BASE RESOURCE FROM THE BUILDING STORAGE AND ADD IT TO THE UNIT ☜ﾟヮﾟ☜)
		# Currently the adding part of this is quick fixed in the request of ComponentManagerDeliver
		# Best is to first request the base resource handle all that stuff
		# Then request the subresource and handle that the same way ╰*°▽°*)╯
		# ---
		# I could also try to simple duplicate the parent node of returned ComponentStorage if it is a
		# ContainerStorage. Then delete(or just hide?) the node from the building storage (for deliveries) and
		# add it to units ComponentStorage.
		var building_sub_storage: ComponentStorage
		var unit_storage: ComponentStorage
		if resource.sub_resource:
			building_sub_storage = building.pick_up_manager.request_sub_resource(building_storage, resource.sub_resource)

		# If base resource available
		if building_storage:
			# Request delivery to unit
			unit_storage = unit.deliver_manager.request(resource)
			# If space availabel on unit storage
			if unit_storage:
				# Pick up resource from building
				building.pick_up_manager.pick_up(building_storage)
				# Deliver to unit
				unit.deliver_manager.deliver(unit_storage)

		# If sub resource available
		if building_sub_storage:
			# Rquest delivery to unit
			var unit_sub_storage := unit.deliver_manager.request_sub_resource(unit_storage, resource.sub_resource)
			# If space availabel on unit sub storage
			if unit_sub_storage:
				# Pick up resource from building
				var amount := building.pick_up_manager.pick_up(building_sub_storage, building_sub_storage.current)
				# Deliver to unit
				unit.deliver_manager.deliver(unit_sub_storage, amount)

	completed.emit()
