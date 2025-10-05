class_name ComponentPickUpManager
extends Node


@export var storages: Array[ComponentStorage]


func request(resource: DataResource, amount := 1) -> float:
	if storages.size() == 0:
		push_error("Pick up requested but no storages defined in Manager!")
		return -1

	for storage in storages:
		if storage.resource == resource and storage.current - amount > 0:
			storage.current =- amount
			return storage.current
		else:
			return storage.current

	return -1
