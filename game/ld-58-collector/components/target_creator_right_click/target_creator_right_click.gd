class_name ComponentTargetCreatorRightClick
extends Node2D


@export var target_scene: PackedScene
@export var target_parent: Node


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("action") and Global.units_selected.size() > 0:
		var unit: UnitDrone = Global.units_selected.keys()[0]
		var new_target: Node2D = target_scene.instantiate()
		new_target.global_position = get_global_mouse_position()
		target_parent.add_child(new_target)
		unit.target = new_target
