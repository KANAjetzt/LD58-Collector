class_name BuildingStorageDepot
extends Building


@export var deactivate_jobs := false
@export var resource: DataResource

@onready var container_storage: ContainerStorage = %ContainerStorage
@onready var job_deliver: ComponentJobDeliver = %JobDeliver
@onready var job_pick_up: ComponentJobPickUp = %JobPickUp
@onready var sprite_selected: Sprite2D = %SpriteSelected
@onready var job_container_deliver: ComponentJobContainer = %"JobContainer-Deliver"
@onready var job_container_pick_up: ComponentJobContainer = %"JobContainer-PickUp"


func _ready() -> void:
	target = %Target
	container_storage.resource = resource
	job_deliver.resource = resource
	job_pick_up.resource = resource


func pick_job(unit: Unit) -> void:
	for job in jobs:
		if job.active:
			job.register(unit)
			return

	# If no jobs where activated manually

	# Check if the unit stores the resource the depot stores then active the delivere job
	if unit.pick_up_manager.request(container_storage.resource):
		job_container_deliver.register(unit, true)
	# If the unit doesn't have the resource in store that the depot stores activate the pickup job
	else:
		job_container_pick_up.register(unit, true)


func _on_target_unit_entered(unit: Unit) -> void:
	if unit.target == target and not deactivate_jobs:
		pick_job(unit)


func _on_responder_right_click_selected() -> void:
	sprite_selected.show()


func _on_responder_right_click_deselected() -> void:
	sprite_selected.hide()
	target.hide()
