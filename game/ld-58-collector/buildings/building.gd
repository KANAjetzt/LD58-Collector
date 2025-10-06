class_name Building
extends Node2D

var target: Target
var pick_up_manager: ComponentPickUpManager
var deliver_manager: ComponentDeliverManager

func activate_target() -> Target:
	target.show()
	return target
