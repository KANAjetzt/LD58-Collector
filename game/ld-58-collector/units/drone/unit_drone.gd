class_name UnitDrone
extends Unit


@onready var movement: ComponentMovement = $Movement
@onready var sprite_selected: Sprite2D = $SpriteSelected


func _ready() -> void:
	job_manager = %JobManager
	pick_up_manager = %PickUpManager
	deliver_manager = %DeliverManager
	route_planer = %RoutePlaner


func select() -> void:
	sprite_selected.show()
	Global.units_selected[self] = "selected"


func deselect() -> void:
	sprite_selected.hide()
	Global.units_selected.erase(self)


func _on_responder_left_click_selected() -> void:
	select()


func _on_responder_left_click_deselected() -> void:
	deselect()


func _on_new_target(target_new: Target) -> void:
	movement.target = target_new.global_position
