class_name Unit
extends Node2D


signal new_target(Target)
signal reached_target(Target)


var target: Target:
	set(new_value):
		if not target == new_value:
			new_target.emit(new_value)

		target = new_value


func signal_target_reached() -> void:
	reached_target.emit(self)
