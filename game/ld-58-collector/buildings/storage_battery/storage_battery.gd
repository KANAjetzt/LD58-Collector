class_name BuildingStorageBattery
extends Building


@export var storage: ComponentStorage
@export var energy := 0
@export var energy_max := 5


func _ready() -> void:
	storage.current = energy
	storage.maximum = energy_max
