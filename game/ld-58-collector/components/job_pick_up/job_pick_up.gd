class_name ComponentJobPickUp
extends Node


@export var location: Building
@export var resource: DataResource
@export var units: Dictionary[Unit, String]


func assign(unit: Unit) -> void:
	units[unit] = "working"
