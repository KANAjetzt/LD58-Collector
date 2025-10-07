extends ComponentLogicBlock


@export var storages: Array[ComponentStorage]
@export var sprites: Array[Sprite2D]


func update(_only_return := false) -> Variant:
	for storage in storages:
		if storage.current > 0:
			for sprite in sprites:
				if not sprite.visible:
					sprite.show()

	return null
