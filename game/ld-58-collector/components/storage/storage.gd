class_name ComponentStorage
extends Node

@export var resource: DataResource
@export var current := 0.0: set = set_current
@export var maximum := 0.0
@export var current_changed_logic_blocks: Array[ComponentLogicBlock]


func set_current(new_value) -> void:
	current = new_value
	for logic_block in current_changed_logic_blocks:
		logic_block.update()
