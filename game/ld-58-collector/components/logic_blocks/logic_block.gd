class_name ComponentLogicBlock
extends Node


## Just returns / applies the set_value
@export var deactivated := false


func update(_only_return := false) -> Variant:
	push_error("No update function defined in LogicBlock, make sure to override the update function!")
	return null
