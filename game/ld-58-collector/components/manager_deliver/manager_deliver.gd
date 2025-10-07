class_name ComponentManagerDeliver
extends Node


@export var storages: Array[ComponentStorage]


# Return available Storage
func request(resource: DataResource) -> ComponentStorage:
	if storages.size() == 0:
		push_error("Delivery requested but no storages defined in Manager!")
		return null

	for storage in storages:
		if storage.resource == resource and storage.current < storage.maximum:
			return storage

	return null


# Return delivered amount
func deliver(storage: ComponentStorage, amount := 1) -> float:
	if storage.current + amount > storage.maximum:
		storage.current = storage.maximum
		return storage.maximum - storage.current
	else:
		storage.current += amount
		return amount
