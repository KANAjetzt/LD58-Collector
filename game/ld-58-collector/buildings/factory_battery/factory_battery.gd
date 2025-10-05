class_name BuildingFactoryBattery
extends Building


@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var producer_resource_battery: ComponentProducerResource = $"ProducerResource-Battery"


func _ready() -> void:
	if producer_resource_battery.can_produce:
		animated_sprite_2d.play()
	else:
		animated_sprite_2d.stop()


func _on_producer_resource_battery_started(_resource: ComponentProducerResource) -> void:
	if animated_sprite_2d:
		animated_sprite_2d.play()


func _on_producer_resource_battery_stoped(_resource: ComponentProducerResource) -> void:
	if animated_sprite_2d:
		animated_sprite_2d.stop()
