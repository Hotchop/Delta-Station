extends Node2D

signal system_jump(type,distance)

@onready var menuTitle: Label = $General/Title
@onready var menuDescription: Label = $General/Description
@onready var systemPlanets: PackedScene = preload("res://Screens/system_cards.tscn")
@onready var menuSprite: AnimatedSprite2D = $"General/Icon Box/AspectRatioContainer/AnimatedSprite2D"

func _ready():
	var scene_instance = systemPlanets.instantiate()
	scene_instance.launch.connect(probe_station_menu)
	Game.nextDay.connect(probe_station_menu) #Debugg

func _process(_delta):
	pass

func set_menu_info(data: ModuleStats):
	menuSprite.sprite_frames = data.moduleLogo
	menuSprite.play("default")
	menuTitle.text = "Module: "+data.moduleName
	if data.energyUse != 0:
		menuDescription.text = "//"+data.moduleDescription+"
		//Hull: "+str("%0.1f"%data.hull)+"%
		//Energy Use: "+str(data.energyUse)+"%"
	else:
		menuDescription.text = "//"+data.moduleDescription+"
		//Hull: "+str("%0.1f"%data.hull)+"%"
	choose_menu(data.moduleName)

func choose_menu(module:String):
	match module:
		"Battery": 
				battery_menu()
		"Observation":
			observation_menu()
		"Probe Station":
			probe_station_menu()
		"Propulsor":
			propulsor_menu()
		"Reactor":
			reactor_menu()
		"Solar Panel Down":
			solar_panel_menu()
		"Solar Panel Up":
			solar_panel_menu()
		_:
			pass

func battery_menu():
	var data: BasicResource = Game.stationResources.battery
	var status: Label = get_node("Battery/Status")
	var info: Label = get_node("Battery/Info")
	var amount: String = "Empty"
	if data.stored >= data.MAX:
		amount = "Full"
	elif data.stored <= data.MAX && data.stored > data.MIN:
		amount = "Storing"
	else:
		amount = "Empty"
	status.text = "Status - "+amount
	info.text = "//Battery Storage In Use:
	//"+str(snapped(data.stored,0.1))+"%
	//currenty duplicating maximum energy reserves"

func observation_menu():
	var status: Label = get_node("Observation/Observation Status")
	var info: Label = $Observation/VBoxContainer/Info
	var button: menu_button = get_node("Observation/VBoxContainer/CenterContainer/Observation Button")
	var button_label: Label = $"Observation/VBoxContainer/CenterContainer/Observation Button/Label"
	var module: ModuleStats = Game.modules.Observation
	var used: bool = Game.stationResources.observer_activated
	var cost = module.energyUse
	var energy: float = Game.stationResources.energy.stored
	if cost <= energy && used == false:
		status.text = "Radar - Active"
		info.text = "//Scan Forward System
		//"+Game.nextSystem.systemName+"
		//"+str(snapped(cost,0.0))+"% energy requiered"
		button.disabled = false
		button_label.text = "Scan"
	elif used == true:
		info.text = "//System Scanned
		//"+Game.nextSystem.systemName+""
		button_label.text = "View"
	else:
		status.text = "Radar - Inactive"
		info.text = "//Energy insufficient
		//"+str(snapped(cost,0.0))+" energy requiered"
		button.disabled = true
		button_label.text = "Need Energy"

func _on_observation_button_pressed():
	if Game.stationResources.observer_activated == false:
		Game.stationResources.observer_activated = true
		Game.stationResources.energy.change_amount(-Game.modules.Observation.energyUse)
	GlobalFlags.view_current_system = false
	get_tree().change_scene_to_packed(systemPlanets)

func probe_station_menu():
	var station = Game.stationResources
	if station.probe_dispatched == false:
		$"Probe Station/Probe Status".text = "Status - Ready"
		$"Probe Station/Probe Description".text = "//Deployment Ready
//System Scan Ready"
		$"Probe Station/Scan Button".disabled = false
		$"Probe Station/Probe Data".visible = false
		$"Probe Station/AnimatedSprite2D".visible = true
		$"Probe Station/Probe Description".visible = true
		$"Probe Station/Scan Button/Label".text = "Scan"

	else:
		$"Probe Station/Probe Status".text = "Status - Deployed"
		$"Probe Station/Probe Data".text = "//Deployed At: "+str(station.probeData.destination.bodyName)+"
		//Estimated Return: "+str(station.probeData.time)+" day(s)
		//Food   "+str("%3.0f"%station.probeData.destination.food.stored)+"% -- //Water  "+str("%3.0f"%station.probeData.destination.water.stored)+"%
		//O2     "+str("%3.0f"%station.probeData.destination.O2.stored)+"% -- //Metal  "+str("%3.0f"%station.probeData.destination.metal.stored)+"%"
		$"Probe Station/Probe Description".visible = false
		$"Probe Station/Scan Button".disabled = true
		$"Probe Station/Probe Data".visible = true
		$"Probe Station/AnimatedSprite2D".visible = false
		$"Probe Station/Scan Button/Label".text = "Waiting"
func _on_scan_button_pressed():
	GlobalFlags.view_current_system = true
	get_tree().change_scene_to_packed(systemPlanets)

func propulsor_menu():
	var module: ModuleStats = Game.modules.Propulsor
	var next:menu_button = get_node("Propulsor/Actions Container/HSplitContainer/CenterContainer2/Next Button")
	var next_label:Label = get_node("Propulsor/Actions Container/HSplitContainer/CenterContainer2/Next Button/Label")
	var skip:menu_button = get_node("Propulsor/Actions Container/HSplitContainer2/CenterContainer2/Skip Button")
	var skip_label:Label = get_node("Propulsor/Actions Container/HSplitContainer2/CenterContainer2/Skip Button/Label")
	var energy: float = Game.stationResources.energy.stored
	if energy >= 50 :
		next_label.text = "Energy "+str(snapped(module.energyUse,0.0))+"%"
		skip_label.text = "Energy "+str(snapped(module.energyUse*2,0.0))+"%"
		next.disabled = false
		skip.disabled = false
	elif  energy < 50 && energy >= 25:
		next_label.text = "Energy "+str(snapped(module.energyUse,0.0))+"%"
		skip_label.text = "Need Energy"
		skip.disabled = true
		next.disabled = false
	else:
		next_label.text = "Need Energy"
		skip_label.text = "Need Energy"
		next.disabled = true
		skip.disabled = true
func _on_next_button_pressed():
	system_jump.emit("Next",1)
func _on_skip_button_pressed():
	system_jump.emit("Skip",2)


func reactor_menu():
	pass

func solar_panel_menu():
	var solar_up_status:Label = get_node("Solar Panel - Upper Deck/Status")
	var solar_low_status:Label = get_node("Solar Panel - Lower Deck/Status")
	var solar_up_info:Label = get_node("Solar Panel - Upper Deck/Info")
	var solar_low_info:Label = get_node("Solar Panel - Lower Deck/Info")
	if Game.currentSystem.starEnergy == 0:
		solar_up_status.text = "Status - Inactive"
		solar_low_status.text = solar_up_status.text
		solar_up_info.text = "//System Star Category:
		//"+Game.currentSystem.starName+"
		//ERROR: STAR NOT DETECTED
		//SOLAR POWER UNAVAILABLE"
		solar_low_info.text = solar_up_info.text
	else:
		solar_up_status.text = "Status - Active"
		solar_low_status.text = solar_up_status.text
		solar_up_info.text = "//System Star Category:
		//"+Game.currentSystem.starName+"
		//Solar Energy Efficiency:
		//"+str(100 * Game.currentSystem.starEnergy)+"%"
		solar_low_info.text = solar_up_info.text



