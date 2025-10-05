class_name BuildingMineOre
extends Building


@onready var animated_sprite_2d: AnimatedSprite2D = %AnimatedSprite2D
@onready var sprite_selected: Sprite2D = $SpriteSelected


func _ready() -> void:
	target = %Target
	pick_up_manager = %PickUpManager


func activate_target() -> Target:
	target.show()
	return target


func _on_producer_resource_started(_resource: ComponentProducerResource) -> void:
	animated_sprite_2d.play()


func _on_producer_resource_stoped(_resource: ComponentProducerResource) -> void:
	animated_sprite_2d.stop()


func _on_responder_right_click_selected() -> void:
	print("MINE SELECTED!")
	Global.buildings_selected[self] = "selected"
	sprite_selected.show()


func _on_responder_right_click_deselected() -> void:
	Global.buildings_selected.erase(self)
	sprite_selected.hide()
	target.hide()
