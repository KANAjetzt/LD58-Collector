## Holds childs nodes that contain ONE Storage
class_name ContainerStorage
extends ComponentStorage


## Defines if the child nodes visiblity is toggled based on the current storage stock
@export var toggle_visiblity := true

var storages: Dictionary[Node, ComponentStorage]
var current_accummulated: int = 0

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
	update()


func update() -> void:
	update_storages_from_childs()
	update_visiblity()
	update_current_accummulated()
	propagate_logic()
	update_logic_blocks()


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
	var childs_visible := []
	var childs_hidden := []

	for child in get_children():
		if child.visible:
			childs_visible.push_back(child)
		else:
			childs_hidden.push_back(child)

	if childs_visible.is_empty() and childs_hidden.is_empty():
		return

	if not childs_visible.size() == current:
		var difference := childs_visible.size() - current
		for i in range(abs(difference)):
			if difference > 0:
				childs_visible[i].hide()
			else:
				childs_hidden[i].show()


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

		var component_update_current_accummulated := ComponentUpdateCurrentAccummulated.new(self)
		child_storage.add_child(component_update_current_accummulated)
		child_storage.current_changed_logic_blocks.push_front(component_update_current_accummulated)


func set_current(new_value) -> void:
	super.set_current(new_value)
	update_storages_from_childs()
	update_visiblity()
	update_current_accummulated()
