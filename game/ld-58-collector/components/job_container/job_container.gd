class_name ComponentJobContainer
extends Node


@export var active := true
@export var building: Building
@export var loop := true
@export var is_route_job := false

var units: Dictionary[Unit, int]
var steps: Array[Node]
var unit: Unit


func _ready() -> void:
	steps = get_children()


func register(register_unit: Unit, ignore_active_state := false) -> void:
	if not active and not ignore_active_state:
		return

	if units.has(register_unit) or register_unit.job_manager.job:
		return

	units[register_unit] = 0
	register_unit.job_manager.start(self)


func unregister(unregister_unit: Unit) -> void:
	units.erase(unregister_unit)
