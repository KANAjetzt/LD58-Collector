class_name ComponentProducerResource
extends Node

signal produced(DataUnit)
signal stoped(ComponentProducerResource)
signal started(ComponentProducerResource)


## False if something is preventing production
@export var can_produce := true : set = set_can_produce
## Resource produced
@export var resource: Resource
## Time until produced
@export var time := 5.0
## Amount produced
@export var amount := 1
@export var storage: ComponentStorage
@export var storage_manager: ComponentStorageManager

@onready var timer: Timer = $Timer


func _ready() -> void:
	start()


func start() -> void:
	if can_produce:
		print("starting production for resource %s" % [resource.display_name])
		timer.start(time)


func set_can_produce(new_value) -> void:
	var previous_value := can_produce
	can_produce = new_value

	if not previous_value == new_value:
		if can_produce:
			started.emit(self)
		else:
			stoped.emit(self)


func _on_timer_timeout() -> void:
	if storage_manager:
		push_error("Storage Manager not implemented yet!")

	if amount + storage.current > storage.maximum:
		storage.current = storage.maximum
	else:
		storage.current += amount

	#print("produced %sx %s" % [amount, resource.display_name])
	produced.emit(resource)
	start()
