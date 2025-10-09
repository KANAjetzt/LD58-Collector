class_name BuildingStorageDepot
extends Building


@export var resource: DataResource :
	set(new_value):
		resource = new_value
		if container_storage:
			container_storage.resource = resource
@export var current_changend_logic_block: Array[ComponentLogicBlock] :
	set(new_value):
		current_changend_logic_block = new_value
		if container_storage:
			container_storage.current_changend_logic_block = current_changend_logic_block
@export var current: int = 0 :
	set(new_value):
		current = new_value
		if container_storage:
			container_storage.current = current
@export var maximum: int = 1 :
	set(new_value):
		maximum = new_value
		if container_storage:
			container_storage.maximum = maximum

@onready var container_storage: ContainerStorage = %ContainerStorage
@onready var job_deliver: ComponentJobDeliver = %JobDeliver
@onready var job_pick_up: ComponentJobPickUp = %JobPickUp
@onready var sprite_selected: Sprite2D = %SpriteSelected


func _ready() -> void:
	job_deliver.resource = resource
	job_pick_up.resource = resource

	if container_storage:
		container_storage.resource = resource
		container_storage.current_changed_logic_blocks = current_changend_logic_block
		container_storage.current = current
		container_storage.maximum = maximum

	target = %Target


func _on_target_unit_entered(unit: Unit) -> void:
	for job in jobs:
		if job.active:
			job.register(unit)
			return


func _on_responder_right_click_selected() -> void:
	sprite_selected.show()


func _on_responder_right_click_deselected() -> void:
	sprite_selected.hide()
	target.hide()
