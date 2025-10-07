# TODO: Would be nice to change this so if one resource
# 		is stored on the drone it allways shows in the center.
class_name ComponentUpdateResourceVisualizer
extends ComponentLogicBlock


@export var storage: ComponentStorage


func _ready() -> void:
	get_child(0).texture = storage.resource.sprite


func update(_only_return := false) -> Variant:
	if storage.current > 0:
		get_child(0).show()
	else:
		get_child(0).hide()
	return null
