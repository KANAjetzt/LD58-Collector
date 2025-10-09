extends ComponentLogicBlock


@export var storages: Array[ComponentStorage]


func update(_only_return := false) -> Variant:
	var storages_current := 0.0
	var storages_max := 0.0
	for storage in storages:
		storages_current += storage.current
		storages_max += storage.maximum

	if storages_current == storages_max:
		Global.end_game(true)

	return null
