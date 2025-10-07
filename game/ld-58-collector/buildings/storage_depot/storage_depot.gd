class_name BuildingStorageDepot
extends Building


@export var resource: DataResource

@onready var storage: ComponentStorage = %Storage
@onready var job_deliver: ComponentJobDeliver = %JobDeliver
@onready var job_pick_up: ComponentJobPickUp = %JobPickUp
@onready var sprite_selected: Sprite2D = %SpriteSelected


func _ready() -> void:
	job_deliver.resource = resource
	job_pick_up.resource = resource
	storage.resource = resource

	target = %Target


func _on_target_unit_entered(unit: Unit) -> void:
	for job in jobs:
		if job.active:
			job.register(unit)
			return


func _on_responder_right_click_selected() -> void:
	sprite_selected.show()


func _on_responder_right_click_deselected() -> void:
	sprite_selected.hide()
	target.hide()
