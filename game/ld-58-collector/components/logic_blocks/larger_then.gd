class_name ComponentLargerThen
extends ComponentLogicBlock


@export var get_nodes: Array[Node]
@export var get_props: Array[String]
@export var set_nodes: Array[Node]
@export var set_props: Array[String]
## If larger then boundary value set props to set_value
@export var set_value := true
## Boundary value
@export var boundary := 0.0
## Can be used to use a node prop instead of a fixed boundary
@export var boundary_node: Node
@export var boundary_prop: String


func update(set_values := true) -> bool:
	if deactivated:
		return set_value

	var accumulator := 0

	if boundary_node:
		boundary = boundary_node[boundary_prop]

	for i in get_nodes.size():
		var node = get_nodes[i]
		accumulator += node[get_props[i]]

	if accumulator > boundary:
		for i in set_nodes.size():
			var node = set_nodes[i]
			if set_values:
				node[set_props[i]] = set_value
		return set_value
	else:
		for i in set_nodes.size():
			var node = set_nodes[i]
			if set_values:
				node[set_props[i]] = !set_value
		return !set_value
