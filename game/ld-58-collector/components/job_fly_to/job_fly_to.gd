class_name ComponentJobFlyTo
extends Node


signal completed


@export var targets: Array[Node2D]


func start() -> void:
	var parent = get_parent()

	if parent is not ComponentJobContainer:
		push_error("Jobs have to be inside a JobContainer!")
		return

	get_parent().unit.target = targets.pick_random().target
	get_parent().unit.reached_target.connect(
		func _on_reached_target(_target: Target) -> void:
			completed.emit()
	)
