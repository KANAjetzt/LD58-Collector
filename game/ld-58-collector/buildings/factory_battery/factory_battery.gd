class_name BuildingFactoryBattery
extends Building


@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var producer_resource_battery: ComponentProducerResource = $"ProducerResource-Battery"
@onready var sprite_selected: Sprite2D = $SpriteSelected
@onready var job_pick_up: ComponentJobPickUp = $Jobs/PickUp


func _ready() -> void:
	target = %Target

	if producer_resource_battery.can_produce:
		animated_sprite_2d.play()
	else:
		animated_sprite_2d.stop()


func activate_target() -> Target:
	target.show()
	return target


func _on_producer_resource_battery_started(_resource: ComponentProducerResource) -> void:
	if animated_sprite_2d:
		animated_sprite_2d.play()


func _on_producer_resource_battery_stoped(_resource: ComponentProducerResource) -> void:
	if animated_sprite_2d:
		animated_sprite_2d.stop()


func _on_responder_right_click_selected() -> void:
	Global.buildings_selected[self] = "selected"
	sprite_selected.show()


func _on_responder_right_click_deselected() -> void:
	Global.buildings_selected.erase(self)
	sprite_selected.hide()
	target.hide()
