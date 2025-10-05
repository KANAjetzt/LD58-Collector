class_name ComponentJobContainer
extends Node

@export var data: DataJob
@export var building: Building

var units: Dictionary[Unit, int]
var steps: Array[Node]


func _ready() -> void:
	steps = get_children()


func register(unit: Unit) -> void:
	units[unit] = 0


func unregister(unit: Unit) -> void:
	units.erase(unit)
