class_name Unit
extends Node2D


signal new_target(Target)
signal reached_target(Target)


var target: Target:
	set(new_value):
		if not target == new_value:
			new_target.emit(new_value)

		target = new_value
var job_manager: ComponentManagerJob
var pick_up_manager: ComponentManagerPickUp
var deliver_manager: ComponentManagerDeliver


func signal_target_reached(target_reached: Target) -> void:
	reached_target.emit(target_reached)
