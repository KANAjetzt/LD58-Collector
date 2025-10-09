class_name ComponentManagerStorage
extends Node


@export var storages: Array[ComponentStorage]
@export var storage_parent: Node
@export var visiblity_changed_logic_blocks: Array[ComponentLogicBlock]


func _ready() -> void:
	if storage_parent:
		# Currently we can assume that the storage_parent contains only battery buildings.
		# I'm sure that will be no problem later.
		for child: BuildingStorageBattery in storage_parent.get_children():
			child.visibility_changed.connect(_on_battery_visibility_changed.bind(child))
			if child.visible:
				storages.push_back(child.storage)


func get_first_not_empty() -> ComponentStorage:
	for storage in storages:
		if storage.current > 0:
			return storage

	if storages.is_empty():
		return null
	else:
		return storages[0]


func get_first_not_full() -> ComponentStorage:
	for storage in storages:
		if storage.current < storage.maximum:
			return storage

	if storages.is_empty():
		return null
	else:
		return storages[0]


## Deprecated!
func get_storage() -> ComponentStorage:
	for storage in storages:
		if storage.current > 0:
			return storage

	if storages[0]:
		return null
	else:
		return storages[0]


func _on_battery_visibility_changed(battery: BuildingStorageBattery) -> void:
	for logic_block in visiblity_changed_logic_blocks:
		logic_block.update()

	if battery.visible and not storages.has(battery.storage):
		storages.push_back(battery.storage)

	if not battery.visible and storages.has(battery.storage):
		storages.erase(battery.storage)
