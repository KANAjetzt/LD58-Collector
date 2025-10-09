class_name ComponentNotNull
extends ComponentLogicBlock


@export var node: Node
@export var prop: String
@export var call_func: String
@export var set_nodes: Array[Node]
@export var set_props: Array[String]
## If exactly boundary value set to set_value
@export var set_value := true


func update(set_values := true) -> bool:
	if prop.is_empty() and call_func.is_empty():
		assert(false, "Please enter a prop to check or a func to call!")

	if prop and call_func:
		assert(false, "Ehh currently only one should be set, maybe use the AND or OR Block?")

	if prop:
		var result = node.get(prop)
		return check(result, set_values)

	if call_func:
		var result = node.call(call_func)
		return check(result, set_values)

	return false


func check(result, set_values) -> bool:
	if result:
		if set_values:
			super._set_setter(set_nodes, set_props, set_value)
		return set_value
	else:
		if set_values:
			super._set_setter_inverse(set_nodes, set_props, set_value)
		return !set_value
