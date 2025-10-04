class_name ComponentProducerResource
extends Node

signal produced(resource, amount)

## Resource consumed for production
@export var consumer: DataConsumer
## Resource produced
@export var resource: DataResource
## Amount produced
@export var amount := 1.0
## Time until produced
@export var time := 5.0
## Where to store resource
@export var storage: Array[DataBuildingStorage]
