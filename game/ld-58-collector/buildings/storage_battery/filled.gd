extends ComponentLogicBlock


signal filled

@export var storage: ComponentStorage


func update(_only_return := false) -> Variant:

	if storage.current == storage.maximum:
		filled.emit()

	return null
