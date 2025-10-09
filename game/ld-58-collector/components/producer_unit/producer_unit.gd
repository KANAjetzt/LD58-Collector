class_name ComponentProducerUnit
extends Node

signal produced(DataUnit)
signal stoped(ComponentProducerUnit)
signal started(ComponentProducerUnit)


## False if something is preventing production
@export var can_produce := true : set = set_can_produce
## Resource consumed for production
@export var consumer: ComponentConsumer
## Unit produced
@export var unit: DataUnit
## Time until produced
@export var time := 5.0
## Resource check interval
@export var time_resource_check := 1.0
## Spawn Point
@export var spawn_point: Node2D

@onready var timer: Timer = $Timer


func _ready() -> void:
	consumer.consumed.connect(_on_consumer_consumed)
	consumer.starved.connect(_on_consumer_starved)
	start()


func start() -> void:
	if can_produce:
		consumer.consume()


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
	# print("starting production for unit %s" % [unit.display_name])
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
	produced.emit(unit)
	var new_unit: Node2D = load(unit.scene_path).instantiate()
	spawn_point.add_child(new_unit)
	start()
