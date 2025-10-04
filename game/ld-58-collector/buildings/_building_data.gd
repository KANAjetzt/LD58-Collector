class_name DataBuilding
extends Resource

## Used to reference in code
@export var id = ""
## Can be used to display the building name in game
@export var display_name = ""
@export var sprites: Texture
## All buildings need batteries
@export var batteries: Array[DataResourceEnergy]

## Sum of all batteries
var energy_count_current := 0.0
var energy_count_max := 0.0
