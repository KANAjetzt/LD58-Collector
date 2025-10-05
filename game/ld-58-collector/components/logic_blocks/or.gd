class_name ComponentOperatorOr
extends ComponentLogicBlock


@export var set_nodes: Array[Node]
@export var set_props: Array[String]
## If larger then boundary value set props to set_value
@export var set_value := true
@export var check_for := true

func update(set_values := true) -> bool:
	if get_child_count() == 0:
		push_warning("No childs in AND logic block")
		return false

	for child in get_children():
		var value = child.update(false)

		if value is not bool:
			push_error("And blocks are only for bool logic blocks")

		if !value:
			return false

	for i in set_nodes.size():
		var node = set_nodes[i]
		if set_values:
			node[set_props[i]] = set_value
	for i in set_nodes.size():
		var node = set_nodes[i]
		if set_values:
			node[set_props[i]] = !set_value

	return true
