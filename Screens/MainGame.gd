extends Node2D

@onready var animation: AnimationPlayer = get_node("BG/Station-background-clear/StarBG-Particles/Warp Animations")

func _ready():
	init_resource_bars()

func init_resource_bars():
	$"UI/Resource Bars/Energy".set_data("Energy",Game.stationResources.energy.stored)
	$"UI/Resource Bars/Battery".set_data("Battery",Game.stationResources.battery.stored)
	$"UI/Resource Bars/Food".set_data("Food",Game.stationResources.food.stored)
	$"UI/Resource Bars/Water".set_data("Water",Game.stationResources.water.stored)
	$"UI/Resource Bars/Oxigen".set_data("Oxigen",Game.stationResources.oxigen.stored)
	$"UI/Resource Bars/Metals".set_data("Metals",Game.stationResources.metals.stored)
	

func _on_system_jump_confirm_alert(string,value):
	var module: ModuleStats = Game.modules.Propulsor
	get_node("Menus/Buttons/System Button").button_pressed = true
	if string == "Next" and value == 1:
		##Consume Energy
		Game.stationResources.consume_energy(module.energyUse)
		##Play jump animation
		animation.play("propulsor_next")
	else:
		##Consume Energy
		Game.stationResources.consume_energy(module.energyUse*2)
		##Play jump animation
		animation.play("propulsor_skip")
	init_resource_bars()

func _on_warp_animations_animation_finished(anim_name):
	if anim_name == "propulsor_next":
		Game.warp_system()
		animation.play("propulsor_arrival")
	elif anim_name == "propulsor_skip":
		Game.jump_system()
		animation.play("propulsor_arrival")


func _on_activate_gravity_confirm_alert(confirm_string, confirm_value):
	var module: ModuleStats = Game.modules.Ring
	Game.stationResources.gravity_activated = true
	get_node("Menus/Buttons/System Button").button_pressed = true
	##Consume Energy
	Game.stationResources.consume_energy(module.energyUse)
	Game.stationResources.consumption -= 15.0
	print("New Station Comsumption: ",Game.stationResources.consumption)
	init_resource_bars()
