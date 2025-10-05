class_name ComponentJobFlyTo
extends Node


@export var targets: Array[Node2D]


func start() -> void:
	var parent = get_parent()

	if parent is not ComponentJobContainer:
		push_error("Jobs have to be inside a JobContainer!")
		return

	get_parent().unit.target = targets.pick_random()
