class_name DataUnit
extends Resource


## Used to reference in code
@export var id = ""
## Can be used to display the building name in game
@export var display_name = ""
@export var sprite: Texture
var storage_max := 1

var location_current: DataBuilding
var location_next: DataBuilding
var storage: Array[DataResource]
