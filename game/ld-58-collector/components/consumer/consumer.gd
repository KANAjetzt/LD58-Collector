class_name ComponentConsumer
extends Node

signal consumed
signal starved

@export var amount := 1.0
## Set to false if only produce once
@export var use_time := true
## Time interval for consumption
@export var time := 1.0
## The Storage compantent where the consumables are stored
@export var storage: ComponentStorage
## Pick Container Storage to consume sub resources (energy instead of batteries)
## Pick Container Storage in storage to consume the resource directly (batteries instead of energy)
@export var container_storage: ContainerStorage


@onready var timer: Timer = $Timer


func _ready() -> void:
	start()


func start() -> void:
	if use_time:
		timer.start(time)


func consume() -> void:
	if container_storage:
		var storage_pick := container_storage.get_first_not_empty()
		if not storage_pick:
			starved.emit()
			return
		if storage_pick.current >= amount:
			storage_pick.current -= amount
			#print("consumed %sx %s" % [amount, storage_pick.resource.display_name])
			consumed.emit()
		else:
			starved.emit()
	else:
		if storage.current >= amount:
			storage.current -= amount
			#print("consumed %sx %s" % [amount, storage.resource.display_name])
			consumed.emit()
		else:
			starved.emit()


func _on_timer_timeout() -> void:
	consume()
	start()
