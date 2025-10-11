extends Node


signal game_over(is_win: bool)
signal building_selected(building: Building)

var units_selected: Dictionary[UnitDrone, String]
var buildings_selected: Dictionary[Variant, String]


func end_game(is_win: bool) -> void:
	game_over.emit(is_win)


func emit_building_selected(building: Building) -> void:
	building_selected.emit(building)
