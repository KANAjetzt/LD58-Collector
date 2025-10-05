class_name ComponentDeliverManager
extends Node


@export var storages: Array[ComponentStorage]


func request(resource: DataResource, amount := 1) -> float:
	if storages.size() == 0:
		push_error("Pick up requested but no storages defined in Manager!")
		return -1

	for storage in storages:
		if storage.resource == resource and storage.current + amount > storage.maximum:
			storage.current = storage.maximum
			return storage.current
		else:
			storage.current += amount
			return storage.current

	return -1
