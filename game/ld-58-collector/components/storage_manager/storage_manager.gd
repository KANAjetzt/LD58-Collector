class_name ComponentStorageManager
extends Node


@export var storages: Array[ComponentStorage]
@export var storage_parent: Node


func _ready() -> void:
	update()

func update() -> void:
	if storage_parent:
		storages.clear()
		for child: BuildingStorageBattery in storage_parent.get_children():
			if child.visible:
				storages.push_back(child.storage)


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
