class_name BuildingFactoryDrone
extends Node2D


@onready var animated_sprite_2d: AnimatedSprite2D = %AnimatedSprite2D


func _on_producer_unit_started(_producer_unit: ComponentProducerUnit) -> void:
	animated_sprite_2d.play()


func _on_producer_unit_stoped(_producer_unit: ComponentProducerUnit) -> void:
	animated_sprite_2d.stop()
