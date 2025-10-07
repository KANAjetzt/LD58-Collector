class_name Building
extends Node2D

@export var target: Target
@export var pick_up_manager: ComponentManagerPickUp
@export var deliver_manager: ComponentManagerDeliver
@export var jobs: Array[ComponentJobContainer]

func activate_target() -> Target:
	target.show()
	return target
