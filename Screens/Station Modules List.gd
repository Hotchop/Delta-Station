extends Resource
class_name Station_Modules_List

@export var Atmosphere_Generator_Base: ModuleStats = load("res://Station Modules/Modules Data/atmosphere_generator_data.tres")
@export var Battery_Base: ModuleStats = load("res://Station Modules/Modules Data/battery_data.tres")
@export var Biosphere_Base: ModuleStats = load("res://Station Modules/Modules Data/biosphere_data.tres")
@export var Materials_Base: ModuleStats = load("res://Station Modules/Modules Data/materials_data.tres")
@export var Observation_Base: ModuleStats = load("res://Station Modules/Modules Data/observation_data.tres")
@export var Probe_Station_Base: ModuleStats = load("res://Station Modules/Modules Data/probe_station_data.tres")
@export var Propulsor_Base: ModuleStats = load("res://Station Modules/Modules Data/propulsor_data.tres")
@export var Reactor_Base: ModuleStats = load("res://Station Modules/Modules Data/reactor_data.tres")
@export var Ring_Base: ModuleStats = load("res://Station Modules/Modules Data/ring_data.tres")
@export var Solar_Lower_Base: ModuleStats = load("res://Station Modules/Modules Data/solar_lower_data.tres")
@export var Solar_Upper_Base: ModuleStats = load("res://Station Modules/Modules Data/solar_upper_data.tres")
@export var Water_Module_Base: ModuleStats = load("res://Station Modules/Modules Data/water_module_data.tres")

@export var Atmosphere_Generator: ModuleStats = ModuleStats.new()
@export var Battery: ModuleStats = ModuleStats.new()
@export var Biosphere: ModuleStats = ModuleStats.new()
@export var Materials: ModuleStats = ModuleStats.new()
@export var Observation: ModuleStats = ModuleStats.new()
@export var Probe_Station: ModuleStats = ModuleStats.new()
@export var Propulsor: ModuleStats = ModuleStats.new()
@export var Reactor: ModuleStats = ModuleStats.new()
@export var Ring: ModuleStats = ModuleStats.new()
@export var Solar_Lower: ModuleStats = ModuleStats.new()
@export var Solar_Upper: ModuleStats = ModuleStats.new()
@export var Water_Module: ModuleStats = ModuleStats.new()

func _init():
	base_values(Atmosphere_Generator,Atmosphere_Generator_Base)
	base_values(Battery,Battery_Base)
	base_values(Biosphere,Biosphere_Base)
	base_values(Materials,Materials_Base)
	base_values(Observation,Observation_Base)
	base_values(Probe_Station,Probe_Station_Base)
	base_values(Propulsor,Propulsor_Base)
	base_values(Reactor,Reactor_Base)
	base_values(Ring,Ring_Base)
	base_values(Solar_Lower,Solar_Lower_Base)
	base_values(Solar_Upper,Solar_Upper_Base)
	base_values(Water_Module,Water_Module_Base)

func base_values(new:ModuleStats,base: ModuleStats):
	new.moduleName = base.moduleName
	new.moduleDescription = base.moduleDescription
	new.moduleLogo = base.moduleLogo
	new.hull = base.hull
	new.energyUse = base.energyUse
	new.has_resource = base.has_resource
	new.resourseName = base.resourseName
	new.resourse = base.resourse

@export var modules_array: Array[ModuleStats] = [Atmosphere_Generator,Battery,Water_Module,Biosphere,Materials,Observation,Probe_Station,Propulsor,Reactor,Ring,Solar_Lower,Solar_Upper]
@export var list: Dictionary = {
	"Atmosphere Generator": Atmosphere_Generator,
	"Battery": Battery,
	"Biosphere": Biosphere,
	"Materials": Materials,
	"Observation": Observation,
	"Probe Station": Probe_Station,
	"Propulsor": Propulsor,
	"Reactor": Reactor,
	"Ring": Ring,
	"Solar Panel - Lower Deck": Solar_Lower,
	"Solar Panel - Upper Deck": Solar_Upper,
	"Water Module":Water_Module,
}

func difficulty_damage():
	var rng = RandomNumberGenerator.new()
	var startDamagedModules: Array[ModuleStats] = []
	var value
	if Game.difficulty != Game.difficultyList["Easy"]:
		for i in modules_array:
			value = rng.randf_range(0,1)
			if value >= Game.difficulty:
				startDamagedModules.append(i)
		for j in startDamagedModules:
			start_damaged(Game.difficulty,j)

func start_damaged(modifier,module: ModuleStats):
	var minHull = (100 * modifier)-10
	var rng = RandomNumberGenerator.new()
	var damage = 100 - rng.randf_range(minHull,100)
	module.damage_hull(damage)
	print("Damaged ",module.moduleName," for ",snapped(damage,0.1),". Current Hull ",snapped(module.hull,0.1))
