class_name ComponentProducerResource
extends Node

signal produced(DataUnit)
signal stoped(ComponentProducerResource)
signal started(ComponentProducerResource)


## False if something is preventing production
@export var can_produce := true : set = set_can_produce
## Resource consumed for production
@export var consumer: ComponentConsumer
## Resource produced
@export var resource: Resource
## Time until produced
@export var time := 5.0
## Resource check interval
@export var time_resource_check := 1.0
## Amount produced
@export var amount := 1
@export var storage: ComponentStorage
@export var storage_container: ContainerStorage

@onready var timer: Timer = $Timer


func _ready() -> void:
	if consumer:
		consumer.consumed.connect(_on_consumer_consumed)
		consumer.starved.connect(_on_consumer_starved)
	start()


func start() -> void:
	if can_produce:
		#print("starting production for resource %s" % [resource.display_name])
		if consumer:
			consumer.consume()
		else:
			timer.start(time)


func set_can_produce(new_value) -> void:
	var previous_value := can_produce
	can_produce = new_value

	if not previous_value == new_value:
		if can_produce:
			started.emit(self)
			start()
		else:
			stoped.emit(self)


func _on_consumer_consumed() -> void:
	can_produce = true
	#print("starting production for unit %s" % [resource.display_name])
	timer.start(time)


func _on_consumer_starved() -> void:
	# Something that can be refactored if needed to wait for a signal from the
	# consumer that new resources arrived.
	can_produce = false

	get_tree().create_timer(time_resource_check).timeout.connect(
		func _on_resource_check_timeout() -> void:
			start()
	)


func _on_timer_timeout() -> void:
	if storage_container:
		storage = storage_container.get_first_not_full()

	if not storage:
		can_produce = false
		return

	if amount + storage.current > storage.maximum:
		storage.current = storage.maximum
	else:
		storage.current += amount

	#print("produced %sx %s" % [amount, resource.display_name])
	produced.emit(resource)
	start()
