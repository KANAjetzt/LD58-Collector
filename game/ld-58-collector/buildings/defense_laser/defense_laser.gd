extends Building


@onready var sprite_select: Sprite2D = %SpriteSelect


func _ready() -> void:
	target = %Target
	deliver_manager = %DeliverManager


func activate_target() -> Target:
	target.show()
	return target


func _on_responder_right_click_selected() -> void:
	sprite_select.show()


func _on_responder_right_click_deselected() -> void:
	sprite_select.hide()
	target.hide()
