class_name ComponentResponderRightClick
extends Area2D


signal selected
signal deselected

@export var parent: Node

var is_hovering := false


func _process(_delta: float) -> void:
	if not is_hovering and Input.is_action_just_pressed("action"):
		deselected.emit()


func _on_mouse_entered() -> void:
	is_hovering = true
	print("hovering")


func _on_mouse_exited() -> void:
	is_hovering = false


func _on_input_event(_viewport: Node, _event: InputEvent, _shape_idx: int) -> void:
	if is_hovering and Input.is_action_just_pressed("action"):
		selected.emit()
