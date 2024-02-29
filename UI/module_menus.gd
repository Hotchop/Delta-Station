extends Node2D

@onready var menuTitle: Label = $General/Title
@onready var menuDescription: Label = $General/Description
@onready var systemPlanets: PackedScene = preload("res://Screens/system_cards.tscn")

func _ready():
	probe_station_menu()
	var scene_instance = systemPlanets.instantiate()
	scene_instance.launch.connect(probe_station_menu)
	Game.nextDay.connect(probe_station_menu) #Debugg

func probe_station_menu():
	var station = Game.stationResources
	if station.probe_dispatched == false:
		$"Probe Station/Probe Status".text = "Probe Status - Ready"
		$"Probe Station/Probe Description".text = "//Probe Ready For Deployment
//System Scan Ready"
		$"Probe Station/Scan Button".disabled = false
		$"Probe Station/Scan Button/Label".text = "Scan"

	else:
		$"Probe Station/Probe Status".text = "Probe Status - Deployed"
		$"Probe Station/Probe Description".text = "//Probe Deployed At:\n"+str(station.probeData.destination.bodyName)+"
		//Estimated Return:\n"+str(station.probeData.time)+" day(s)"
		#//Collecting
		#//Food "+str(station.probeData.destination.food.stored)+"%
		#//Water "+str(station.probeData.destination.water.stored)+"%
		#//O2 "+str(station.probeData.destination.O2.stored)+"%
		#//Metal "+str(station.probeData.destination.metal.stored)+"%"
		$"Probe Station/Scan Button".disabled = true
		$"Probe Station/Scan Button/Label".text = "Waiting"
func _on_scan_button_pressed():
	get_tree().change_scene_to_packed(systemPlanets)