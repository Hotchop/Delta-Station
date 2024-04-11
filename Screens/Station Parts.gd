extends Node2D

signal toggle_menu(moduleName: String,data: ModuleStats)
@onready var modulesButtonGroup: ButtonGroup = preload("res://Settings/station_modules.tres")
#var startDamagedModules = []

func _ready():
	modulesButtonGroup.pressed.connect(_show_module_menu)
	var aux
	var modules = get_children()
	for i in modules:
		aux = i.get_node("Station Module")
		aux.module = Game.modules.list[i.name]
	#Game.inital_damage.connect(difficulty_damage)

#func difficulty_damage():
	#var rng = RandomNumberGenerator.new()
	#var value
	#if Game.difficulty != Game.difficultyList["Easy"]:
		#var modules = get_children()
		#for i in modules:
			#value = rng.randf_range(0,1)
			#if value >= Game.difficulty:
				#startDamagedModules.append(i)
		#for j in startDamagedModules:
			#var child = j.get_node("Station Module")
			#if child.has_method("start_damaged"):
				#child.start_damaged(Game.difficulty)

func _show_module_menu(button: BaseButton):
	print("Pressed "+button.name)
	toggle_menu.emit(button.name,button.get_node("Station Module").module)
