class_name ComponentRoutePlaner
extends Node


@export var drone: UnitDrone

var route: Array[Target] = []
var route_step := 0
var is_started := false
var is_loop := false
var is_drone_selected := false

# If a Drone is selected and a storage depot is clicked
# Add active Storage job to Route
# If start storage depot is added as the last one create a loop
# Bonus Points: Add a line between each storage depots


func _ready() -> void:
	Global.building_selected.connect(_on_global_building_selected)


func clear() -> void:
	route.clear()
	route_step = 0
	is_started = false
	is_loop = false


func _on_global_building_selected(building: Building) -> void:
	if is_drone_selected and building is BuildingStorageDepot and Input.is_action_pressed("modifier"):
		route.push_back(building.target)


func _on_responder_left_click_deselected() -> void:
	# Loop if the first and the last target are the same
	if not is_started:
		if is_drone_selected and route.size() > 1 and route[0] == route[-1]:
			is_loop = true
		else:
			is_loop = false

		if not route.is_empty():
			is_started = true
			drone.target = route[0]

	is_drone_selected = false


func _on_responder_left_click_selected() -> void:
	is_drone_selected = true


func _on_job_manager_jop_stoped() -> void:
	if is_started:
		route_step += 1

		if route_step == route.size():
			if is_loop:
				route_step = 1
			else:
				clear()
				return

		drone.target = route[route_step]


func _on_unit_drone_new_target(_target: Target) -> void:
	pass
