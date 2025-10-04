class_name ComponentStorageManager
extends Node

@export var storages: Array[ComponentStorage]


func get_storage() -> ComponentStorage:
	return storages[0]
