class_name ComponentLogicBlock
extends Node


## Just returns / applies the set_value
@export var deactivated := false


func update(_only_return := false) -> Variant:
	push_error("No update function defined in LogicBlock, make sure to override the update function!")
	return null


func _set_setter(set_nodes: Array[Node], set_props: Array[String], set_value: bool) -> void:
	for i in set_nodes.size():
		var node = set_nodes[i]
		node[set_props[i]] = set_value


func _set_setter_inverse(set_nodes: Array[Node], set_props: Array[String], set_value: bool) -> void:
	for i in set_nodes.size():
		var node = set_nodes[i]
		node[set_props[i]] = !set_value
