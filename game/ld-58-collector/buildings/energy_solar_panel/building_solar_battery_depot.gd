extends Building


func _ready() -> void:
	target = %"Target-BatteryDepot"


func activate_target() -> Target:
	target.show()
	return target
