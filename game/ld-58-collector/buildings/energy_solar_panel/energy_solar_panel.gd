class_name BuildingEnergySolarPanel
extends Building


@onready var sprite_selected: Sprite2D = %SpriteSelected
@onready var not_null_storage_manager_storages: ComponentNotNull = %"NotNull-StorageManager-Storages"


func _ready() -> void:
	target = %"Target-SolarPanel"
	not_null_storage_manager_storages.update()


func activate_target() -> Target:
	target.show()
	return target


func _on_responder_right_click_selected() -> void:
	sprite_selected.show()


func _on_responder_right_click_deselected() -> void:
	sprite_selected.hide()
	target.hide()
