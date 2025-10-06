class_name ComponentJobCheckForFullBattery
extends Node


signal completed
signal aborted


@export var batteries: Array[BuildingStorageBattery]
@export var batteries_parent: Node


func _ready() -> void:
	if batteries_parent:
		batteries.assign(batteries_parent.get_children())


func start() -> void:
	for battery in batteries:
		if battery.storage.current == battery.storage.maximum:
			completed.emit()
			return

	aborted.emit()
