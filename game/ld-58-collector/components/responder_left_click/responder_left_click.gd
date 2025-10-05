class_name ComponentResponderLeftClick
extends Area2D


signal selected
signal deselected

var is_hovering := false


func _process(_delta: float) -> void:
	if not is_hovering and Input.is_action_just_pressed("select"):
		print("deselected")
		deselected.emit()


func _on_mouse_entered() -> void:
	is_hovering = true


func _on_mouse_exited() -> void:
	is_hovering = false


func _on_input_event(_viewport: Node, _event: InputEvent, _shape_idx: int) -> void:
	if is_hovering and Input.is_action_just_pressed("select"):
		print("selected")
		selected.emit()
