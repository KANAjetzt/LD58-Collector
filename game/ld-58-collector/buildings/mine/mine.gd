extends Node2D


@onready var animated_sprite_2d: AnimatedSprite2D = %AnimatedSprite2D


func _on_producer_resource_started(_resource: ComponentProducerResource) -> void:
	animated_sprite_2d.play()


func _on_producer_resource_stoped(_resource: ComponentProducerResource) -> void:
	animated_sprite_2d.stop()
