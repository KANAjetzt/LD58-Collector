class_name Building
extends Node2D

@export var target: Target
@export var pick_up_manager: ComponentPickUpManager
@export var deliver_manager: ComponentDeliverManager
@export var jobs: Array[ComponentJobContainer]

func activate_target() -> Target:
	target.show()
	return target
