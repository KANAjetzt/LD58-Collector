class_name BuildingStorageBattery
extends Building


signal filled

@export var storage: ComponentStorage
@export var energy := 0
@export var energy_max := 5

@onready var update_sprite: ComponentUpdateSprite = $UpdateSprite


func _ready() -> void:
	storage.current = energy
	storage.maximum = energy_max
	update_sprite.update()


func _on_filled_filled() -> void:
	filled.emit()
