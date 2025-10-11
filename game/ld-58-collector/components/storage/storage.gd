class_name ComponentStorage
extends Node

@export var resource: DataResource
@export var current: int = 0 : set = set_current
@export var maximum: int = 0
@export var current_changed_logic_blocks: Array[ComponentLogicBlock]


func set_current(new_value) -> void:
	current = new_value
	update_logic_blocks()


func _ready() -> void:
	if maximum == 0:
		push_warning("Storage maximum is set to 0, that's most likely unintentional.")


func update_logic_blocks() -> void:
	for logic_block in current_changed_logic_blocks:
		logic_block.update()
