class_name ComponentStorageManager
extends Node

@export var storages: Array[ComponentStorage]


func get_first_not_empty() -> ComponentStorage:
	for storage in storages:
		if storage.current > 0:
			return storage

	return storages[0]


func get_first_not_full() -> ComponentStorage:
	for storage in storages:
		if storage.current < storage.maximum:
			return storage

	return storages[0]


## Deprecated!
func get_storage() -> ComponentStorage:
	for storage in storages:
		if storage.current > 0:
			return storage

	return storages[0]
