class_name ComponentJobWait
extends Node


signal completed

@export var time := 2.0

@onready var timer: Timer = $Timer


func start() -> void:
	var parent = get_parent()

	if parent is not ComponentJobContainer:
		push_error("Jobs have to be inside a JobContainer!")
		return

	timer.start(time)


func _on_timer_timeout() -> void:
	completed.emit()
