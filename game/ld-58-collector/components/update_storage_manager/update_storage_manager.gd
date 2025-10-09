class_name ComponentUpdateStorageManager
extends ComponentLogicBlock


@export var storage_manager: ComponentManagerStorage


func update(_only_return := false) -> Variant:
	storage_manager.update()

	return null
