class_name BuildingStorageBattery
extends Building


signal filled

@export var storage: ComponentStorage
@export var energy := 0
@export var energy_max := 5


func _ready() -> void:
	storage.current = energy
	storage.maximum = energy_max


func _on_filled_filled() -> void:
	filled.emit()
