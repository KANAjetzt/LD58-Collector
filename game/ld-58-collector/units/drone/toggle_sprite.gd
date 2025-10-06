extends ComponentLogicBlock


@export var storages: Array[ComponentStorage]
@export var sprites: Array[Sprite2D]

func update(_only_return := false) -> Variant:
	for storage in storages:
		if storage.resource.id == "resource_battery_empty" and storage.current > 0:
			sprites[0].show()
		else:
			sprites[0].hide()
		if storage.resource.id == "resource_battery_full" and storage.current > 0:
			sprites[1].show()
		else:
			sprites[1].hide()
		if storage.resource.id == "resource_ore" and storage.current > 0:
			sprites[2].show()
		else:
			sprites[2].hide()

	return null
