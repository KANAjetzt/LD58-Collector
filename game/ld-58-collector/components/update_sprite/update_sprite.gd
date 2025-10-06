class_name ComponentUpdateSprite
extends ComponentLogicBlock


@export var sprite: AnimatedSprite2D
@export var storage: ComponentStorage


func update(_only_return := false) -> int:
	sprite.frame = int(storage.current)
	return sprite.frame
