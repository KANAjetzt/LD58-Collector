class_name BuildingFactoryDrone
extends Building


@onready var animated_sprite_2d: AnimatedSprite2D = %AnimatedSprite2D
@onready var producer_unit_drone: ComponentProducerUnit = %"ProducerUnit-Drone"
@onready var job_container_deliver_ore: ComponentJobContainer = %"JobContainer-Deliver-Ore"
@onready var sprite_selected: Sprite2D = %SpriteSelected


func _ready() -> void:
	target = %Target

	if producer_unit_drone.can_produce:
		animated_sprite_2d.play()
	else:
		animated_sprite_2d.stop()


func activate_target() -> Target:
	target.show()
	return target


func _on_producer_unit_started(_producer_unit: ComponentProducerUnit) -> void:
	if animated_sprite_2d:
		animated_sprite_2d.play()


func _on_producer_unit_stoped(_producer_unit: ComponentProducerUnit) -> void:
	if animated_sprite_2d:
		animated_sprite_2d.stop()


func _on_responder_right_click_selected() -> void:
	#Global.buildings_selected[self] = "selected"
	sprite_selected.show()


func _on_responder_right_click_deselected() -> void:
	#Global.buildings_selected.erase(self)
	sprite_selected.hide()
	target.hide()


func _on_target_unit_entered(unit: Unit) -> void:
	job_container_deliver_ore.register(unit)
