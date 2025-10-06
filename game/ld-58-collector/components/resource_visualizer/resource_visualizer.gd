class_name ComponentResourceVisualizer
extends Sprite2D


@export var resource: DataResource:
	set(new_value):
		resource = new_value
		texture = resource.sprite
