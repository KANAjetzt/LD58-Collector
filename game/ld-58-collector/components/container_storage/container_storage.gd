## Holds childs nodes that contain ONE Storage
class_name ContainerStorage
extends ComponentStorage


## Defines if the child nodes visiblity is toggled based on the current storage stock
@export var toggle_visiblity := true

var storages: Dictionary[Node, ComponentStorage]
var current_accummulated := 0

# ༼ つ ◕_◕ ༽つ That's really terrible - I have to fix that at some point. ༼ つ ◕_◕ ༽つ
class ComponentUpdateCurrentAccummulated:
	extends ComponentLogicBlock

	var container_storage: ContainerStorage

	func _init(_container_storage: ContainerStorage) -> void:
		container_storage = _container_storage
		name = "UpdateCurrentAccummulated"


	func update(_only_return := false) -> Variant:
		var new_current_accummulated = 0

		for storage: ComponentStorage in container_storage.storages.values():
			new_current_accummulated += storage.current

		container_storage.current_accummulated = new_current_accummulated

		return null


func _ready() -> void:
	update_storages_from_childs()
	update_visiblity()
	update_current_accummulated()
	propagate_logic()


func update_storages_from_childs() -> void:
	if get_child_count() >= current:
		for i in range(current):
			var child: Node = get_child(i)
			if not child:
				continue
			var storage = child.get("storage")

			if child is ComponentStorage:
				storage = child

			if storage:
				storages[child] = storage


func get_first() -> ComponentStorage:
	if storages.is_empty():
		return null
	else:
		return storages.values()[0]


func get_first_not_empty() -> ComponentStorage:
	var storages_values := storages.values()

	for storage in storages_values:
		if storage.current > 0:
			return storage

	if storages.is_empty():
		return null
	else:
		return storages_values[0]


func get_first_not_full() -> ComponentStorage:
	var storages_values := storages.values()

	for storage in storages_values:
		if storage.current < storage.maximum:
			return storage

	if storages_values.is_empty():
		return null
	else:
		return storages_values[0]


func get_first_empty() -> ComponentStorage:
	var storages_values := storages.values()

	for storage in storages_values:
		if storage.current == 0:
			return storage

	return null


func get_first_full() -> ComponentStorage:
	var storages_values := storages.values()

	for storage in storages_values:
		if storage.current == storage.maximum:
			return storage

	return null


func update_visiblity() -> void:
	var childs_visible := 0

	for child: Node2D in get_children():
		if child.visible:
			childs_visible += 1

		if childs_visible > current:
			child.hide()
		if childs_visible < current and not child.visible:
			child.show()
			childs_visible += 1


func update_current_accummulated() -> void:
	var new_current_accummulated = 0

	for storage: ComponentStorage in storages.values():
		new_current_accummulated += storage.current

	current_accummulated = new_current_accummulated


func propagate_logic() -> void:
	for child in get_children():
		var child_storage: ComponentStorage = child.get("storage")

		if child is ComponentStorage:
			child_storage = child

		if child_storage == null:
			continue

		child_storage.current_changed_logic_blocks.append_array(current_changed_logic_blocks)

		child_storage.current_changed_logic_blocks.push_front(ComponentUpdateCurrentAccummulated.new(self))

		print(get_parent().name, " ", child_storage.current_changed_logic_blocks)


func set_current(new_value) -> void:
	super.set_current(new_value)
	update_storages_from_childs()
	update_visiblity()
	update_current_accummulated()
