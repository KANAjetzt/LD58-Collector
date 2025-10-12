class_name Target
extends Node2D


signal unit_entered(unit: Unit)

@export var parent: Node2D


func clear() -> void:
	queue_free()


func _on_area_2d_area_entered(area: ComponentZoneUnit) -> void:
	var unit := area.parent
	if unit.target == self:
		unit.signal_target_reached(self)
	unit_entered.emit(unit)
