class_name ComponentLogicBlock
extends Node


func update(_only_return := false) -> Variant:
	push_error("No update function defined in LogicBlock, make sure to override the update function!")
	return null
