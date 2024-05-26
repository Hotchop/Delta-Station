extends Resource
class_name ModuleStats

const  MAX_HULL = 100

@export var moduleName: String = "Module"
@export var moduleDescription: String = "A module"
@export var hull: float = MAX_HULL
@export var is_destroyed: bool = false
@export var energyUse: float = 25
@export var moduleLogo: SpriteFrames
@export var has_resource: bool = false
@export var resourseName: String = "Resourse"
@export var resourse: BasicResource

func repair_hull(amount: float):
	hull += amount
	if hull > MAX_HULL:
		hull = MAX_HULL

func damage_hull(amount: float):
	hull -= amount
	if hull <= 0:
		hull = 0
		is_destroyed = true
