class_name ComponentRoutePlaner
extends Node


@export var drone: UnitDrone

var route: Array[Target] = []
var route_step := 0
var is_started := false
var is_loop := false
var is_drone_selected := false

@onready var line_2d: Line2D = $Line2D

# If a Drone is selected and a storage depot is clicked
# Add active Storage job to Route
# If start storage depot is added as the last one create a loop
# Bonus Points: Add a line between each storage depots


func _ready() -> void:
	Global.building_selected.connect(_on_global_building_selected)


func _process(delta: float) -> void:
	if Input.is_action_pressed("show_routes"):
		line_2d.show()
	if Input.is_action_just_released("show_routes"):
		line_2d.hide()


func clear() -> void:
	route.clear()
	route_step = 0
	is_started = false
	is_loop = false
	line_2d.clear_points()


func _on_global_building_selected(building: Building) -> void:
	if is_drone_selected and building is BuildingStorageDepot and Input.is_action_pressed("modifier"):
		route.push_back(building.target)
		line_2d.add_point(building.target.global_position)


func _on_responder_left_click_deselected() -> void:
	if is_drone_selected:
		# Loop if the first and the last target are the same
		if not is_started:
			if is_drone_selected and route.size() > 1 and route[0] == route[-1]:
				is_loop = true
				line_2d.remove_point(line_2d.get_point_count() - 1)
			else:
				is_loop = false

			if not route.is_empty():
				is_started = true
				drone.target = route[0]

		is_drone_selected = false
		line_2d.hide()


func _on_responder_left_click_selected() -> void:
	is_drone_selected = true
	line_2d.show()


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
