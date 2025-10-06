class_name ComponentChildHider
extends ComponentLogicBlock


@export var storage: ComponentStorage


func update(_only_return := false) -> Variant:
	var childs_visible := 0

	for child: Node2D in get_children():
		if child.visible:
			childs_visible += 1

		if childs_visible > storage.current:
			child.hide()
		if childs_visible < storage.current and not child.visible:
			child.show()
			childs_visible += 1

	return null
