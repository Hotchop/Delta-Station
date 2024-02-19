extends Control

@onready var selectedButton: BaseButton = $"Buttons/System Button"

func _ready():
	system_menu_data()

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

func _on_system_button_toggled(toggled_on):
	selectedButton.get_child(0).visible = false
	$"Buttons/System Button/System Menu".visible = true
	selectedButton = $"Buttons/System Button"

func _on_module_button_toggled(toggled_on):
	selectedButton.get_child(0).visible = false
	$"Buttons/Module Button/Module Menu".visible = true
	selectedButton = $"Buttons/Module Button"

func _on_codex_button_toggled(toggled_on):
	selectedButton.get_child(0).visible = false
	$"Buttons/Codex Button/Codex Menu".visible = true
	selectedButton = $"Buttons/Codex Button"

func _on_settings_button_toggled(toggled_on):
	selectedButton.get_child(0).visible = false
	$"Buttons/Settings Button/Settings Menu".visible = true
	selectedButton = $"Buttons/Settings Button"
