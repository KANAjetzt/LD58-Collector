class_name BuildingEnergySolarPanel
extends Building


@onready var sprite_selected: Sprite2D = %SpriteSelected
@onready var job_container_deliver_batteries: ComponentJobContainer = $"JobContainer-Deliver-Batteries"


func _ready() -> void:
	target = %Target
	deliver_manager = %DeliverManager


func _on_responder_right_click_selected() -> void:
	sprite_selected.show()


func _on_responder_right_click_deselected() -> void:
	sprite_selected.hide()
	target.hide()


func _on_target_unit_entered(unit: Unit) -> void:
	job_container_deliver_batteries.register(unit)
