class_name ComponentStorageManager
extends Node

@export var storages: Array[ComponentStorage]


func get_storage() -> ComponentStorage:
	for storage in storages:
		if storage.current > 0:
			return storage

	return storages[0]
