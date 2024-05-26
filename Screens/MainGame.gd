extends Node2D

@onready var animation: AnimationPlayer = get_node("BG/Station-background-clear/StarBG-Particles/Warp Animations")

func _on_system_jump_confirm_alert(string,value):
	var module: ModuleStats = Game.modules.Propulsor
	var energy: BasicResource = Game.stationResources.energy
	get_node("Menus/Buttons/System Button").button_pressed = true
	if string == "Next" and value == 1:
		##Consume Energy
		energy.change_amount(-module.energyUse)
		##Play jump animation
		animation.play("propulsor_next")
	else:
		##Consume Energy
		energy.change_amount(-module.energyUse*2)
		##Play jump animation
		animation.play("propulsor_skip")

func _on_warp_animations_animation_finished(anim_name):
	if anim_name == "propulsor_next":
		Game.warp_system()
		animation.play("propulsor_arrival")
	elif anim_name == "propulsor_skip":
		Game.jump_system()
		animation.play("propulsor_arrival")
