extends Resource
class_name GameData

@export var saveName: String
@export var date: int
@export var stationResources: StationResourses
@export var currentSystem: StarSystem
@export var nextSystem: StarSystem
@export var futureSystem: StarSystem
@export var modules: Station_Modules_List
@export var difficulty: float

func _init(name = "Normal - Day 1"):
	saveName = name
