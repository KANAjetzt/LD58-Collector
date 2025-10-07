class_name ComponentManagerPickUp
extends Node


@export var storages: Array[ComponentStorage]


# Return available Storage
func request(resource: DataResource) -> ComponentStorage:
	if storages.size() == 0:
		push_error("Pick up requested but no storages defined in Manager!")
		return null

	for storage in storages:
		if storage.resource == resource and storage.current > 0:
			return storage

	return null


# Return picked up amount
func pick_up(storage: ComponentStorage, amount := 1) -> float:
	if storage.current - amount > 0:
		storage.current -= amount
		return amount
	else:
		var left_over := storage.current
		storage.current = 0
		return left_over
