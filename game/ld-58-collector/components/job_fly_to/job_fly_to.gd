class_name ComponentJobFlyTo
extends Node


signal completed


@export var buildings: Array[Building]


func start() -> void:
	var parent = get_parent()

	if parent is not ComponentJobContainer:
		push_error("Jobs have to be inside a JobContainer!")
		return

	var target: Target = buildings.pick_random().target
	get_parent().unit.target = target
	target.unit_entered.connect(
		func _on_unit_entered(unit: Unit) -> void:
			if unit == get_parent().unit:
				completed.emit()
	)
