extends Control

@onready var selectedButton: BaseButton = $"Buttons/System Button"
@onready var moduleMenusScene: PackedScene = preload("res://UI/module_menus.tscn")
var modulesMenus: Node2D
var noMenu: Control
var generalMenu: Control
var visibleMenu: Control

func _ready():
	$"Buttons/System Button/System Menu".visible = true
	system_menu_data()
	modulesMenus = moduleMenusScene.instantiate() as Node2D
	modulesMenus.system_jump.connect(system_jump_alert)
	modulesMenus.activate_gravity.connect(activate_gravity_alert)
	$"Buttons/Module Button/Module Menu".add_child(modulesMenus)
	modulesMenus.global_position = Vector2(20,776)
	noMenu = modulesMenus.get_node("No Module")
	generalMenu = modulesMenus.get_node("General")
	
	Game.nextDay.connect(system_menu_data) #debugg

func _process(_delta):
	pass

func system_menu_data():
	var systemData: StarSystem = Game.currentSystem
	var systemSprite: Sprite2D = $"Buttons/System Button/System Menu/Frame/System Sprite"
	var title: Label = $"Buttons/System Button/System Menu/System Name"
	var description: Label = $"Buttons/System Button/System Menu/Description"
	title.text = "System: "+systemData.systemName
	description.text = "//Star Type: "+systemData.starName+"
	//Solar Power: "+str(100*systemData.starEnergy)+"%
	//Celestial Bodies Detected: "+str(systemData.totalBodies)
	if systemData.starType != 0:
		systemSprite.texture.region = Rect2(2,2,224,224)
	else :
		systemSprite.texture.region = Rect2(230,2,224,224)

func module_menu_data():
	pass

func codex_menu_data():
	pass

func settings_menu_data():
	pass

func _on_system_button_toggled(_toggled_on):
	selectedButton.get_child(0).visible = false
	$"Buttons/System Button/System Menu".visible = true
	selectedButton = $"Buttons/System Button"

func _on_module_button_toggled(_toggled_on):
	selectedButton.get_child(0).visible = false
	$"Buttons/Module Button/Module Menu".visible = true
	selectedButton = $"Buttons/Module Button"

func _on_codex_button_toggled(_toggled_on):
	selectedButton.get_child(0).visible = false
	$"Buttons/Codex Button/Codex Menu".visible = true
	selectedButton = $"Buttons/Codex Button"

func _on_settings_button_toggled(_toggled_on):
	selectedButton.get_child(0).visible = false
	$"Buttons/Settings Button/Settings Menu".visible = true
	selectedButton = $"Buttons/Settings Button"


func _on_station_parts_toggle_menu(moduleName,data):
	modulesMenus.set_menu_info(data)
	$"Buttons/Module Button".button_pressed = true
	if noMenu.visible == true:
		noMenu.visible = false
		generalMenu.visible = true
		visibleMenu = modulesMenus.get_node(str(moduleName))
		visibleMenu.visible = true
	else:
		visibleMenu.visible = false
		visibleMenu = modulesMenus.get_node(str(moduleName))
		modulesMenus.get_node(str(moduleName)).visible = true
	print("Showing "+visibleMenu.name+" menu")

func system_jump_alert(string,value):
	if value == 1:
		$"../Alerts/System Jump".set_info("Preparing warp jump","Jumping to next system
	Confirmation Requiered")
	else:
		$"../Alerts/System Jump".set_info("Preparing warp jump","Skiping next system
	Confirmation Requiered")
	$"../Alerts/System Jump".set_data(string,value)
	$"../Alerts/System Jump".visible = true

func activate_gravity_alert():
	var use: float = Game.modules.Ring.energyUse
	$"../Alerts/Activate Gravity".set_info("Activate Station Gravity","Station Gravity will be activated
		Energy consumption -> "+str(snapped(use,1))+"%")	
	$"../Alerts/Activate Gravity".set_data("",0)
	$"../Alerts/Activate Gravity".visible = true
