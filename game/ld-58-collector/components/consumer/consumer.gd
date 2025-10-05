class_name ComponentConsumer
extends Node

signal consumed(DataResource, float)
signal starved(DataResource)

@export var amount := 1.0
## Set to false if only produce once
@export var use_time := true
## Time interval for consumption
@export var time := 1.0
## The Storage compantent where the consumables are stored
@export var storage: ComponentStorage
## Use Storage manager if more then one storage is used
@export var storage_manager: ComponentStorageManager


@onready var timer: Timer = $Timer


func _ready() -> void:
	start()


func start() -> void:
	if use_time:
		timer.start(time)


func consume() -> void:
	if storage_manager:
		var storage_pick := storage_manager.get_storage()
		if storage_pick.current >= amount:
			storage_pick.current -= amount
			print("consumed %sx %s" % [amount, storage_pick.resource.display_name])
			consumed.emit(storage_pick.resource, amount)
		else:
			starved.emit(storage_pick.resource)
	else:
		if storage.current >= amount:
			storage.current -= amount
			print("consumed %sx %s" % [amount, storage.resource.display_name])
			consumed.emit(storage.resource, amount)
		else:
			starved.emit(storage.resource)


func _on_timer_timeout() -> void:
	consume()
	start()
