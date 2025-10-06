class_name BuildingEnergySolarPanel
extends Building


@onready var sprite_selected: Sprite2D = %SpriteSelected
@onready var job_container_deliver_batteries: ComponentJobContainer = $"JobContainer-Deliver-Batteries"
@onready var sprite_selected_battery_depot: Sprite2D = %"SpriteSelected-BatteryDepot"
@onready var target_battery_depot: Target = %"Target-BatteryDepot"
@onready var job_container_pickup: ComponentJobContainer = %"JobContainer-Pickup-Battery"


func _ready() -> void:
	target = %"Target-SolarPanel"
	deliver_manager = %DeliverManager


func activate_target() -> Target:
	target.show()
	return target


func _on_responder_right_click_selected() -> void:
	sprite_selected.show()


func _on_responder_right_click_deselected() -> void:
	sprite_selected.hide()
	target.hide()


func _on_target_unit_entered(unit: Unit) -> void:
	job_container_deliver_batteries.register(unit)


func _on_responder_right_click_battery_depot_selected() -> void:
	sprite_selected_battery_depot.show()


func _on_responder_right_click_battery_depot_deselected() -> void:
	sprite_selected_battery_depot.hide()
	target.hide()


func _on_target_battery_depot_unit_entered(unit: Unit) -> void:
	job_container_pickup.register(unit)
