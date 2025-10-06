class_name ComponentOperatorAnd
extends ComponentLogicBlock


@export var set_nodes: Array[Node]
@export var set_props: Array[String]
## If all childs are true the set_props are set to the set_value
@export var set_value := true


func update(set_values := true) -> bool:
	var result := true

	if get_child_count() == 0:
		push_warning("No childs in AND logic block")
		return false

	for child in get_children():
		var value = child.update(false)

		if value is not bool:
			push_error("And blocks are only for bool logic blocks")

		if !value:
			result = false
			break

	if result:
		for i in set_nodes.size():
			var node = set_nodes[i]
			if set_values:
				node[set_props[i]] = set_value
		return true
	else:
		for i in set_nodes.size():
			var node = set_nodes[i]
			if set_values:
				node[set_props[i]] = !set_value
		return false
