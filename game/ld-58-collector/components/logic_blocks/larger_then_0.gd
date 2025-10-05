class_name ComponentLargerThenZero
extends ComponentLogicBlock

@export var get_nodes: Array[Node]
@export var get_props: Array[String]
@export var set_nodes: Array[Node]
@export var set_props: Array[String]
## If larger the 0 set to true
@export var set_value := true


func update() -> void:
	var accumulator := 0

	for i in get_nodes.size():
		var node = get_nodes[i]
		accumulator += node[get_props[i]]

	if accumulator > 0:
		for i in set_nodes.size():
			var node = set_nodes[i]
			node[set_props[i]] = true
	else:
		for i in set_nodes.size():
			var node = set_nodes[i]
			node[set_props[i]] = false
