class_name ComponentResponderLeftClick
extends Area2D


signal selected
signal deselected

var is_selected := false
var is_hovering := false


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("select") and is_selected and not is_hovering:
		print("deselected")
		deselected.emit()


func _on_mouse_entered() -> void:
	is_hovering = true
	print("hovering")


func _on_mouse_exited() -> void:
	is_hovering = false


func _on_input_event(_viewport: Node, _event: InputEvent, _shape_idx: int) -> void:
	if is_hovering and Input.is_action_just_pressed("select"):
		print("selected")
		is_selected = true
		selected.emit()
