class_name ComponentProducerUnit
extends Node

signal produced(DataUnit)

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
	consumer.consume()


func _on_consumer_consumed(_resource: DataResource, _amount: float) -> void:
	print("starting production for unit %s" % [unit.display_name])
	timer.start(time)


func _on_consumer_starved(_resource: DataResource) -> void:
	# Something that can be refactored if needed to wait for a signal from the
	# consumer that new resources arrived.
	get_tree().create_timer(time_resource_check).timeout.connect(
		func _on_resource_check_timeout() -> void:
			start()
	)

func _on_timer_timeout() -> void:
	produced.emit(unit)
	var new_unit: Node2D = load(unit.scene_path).instantiate()
	spawn_point.add_child(new_unit)
