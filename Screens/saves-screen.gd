extends Node2D
@onready var _save1:menu_button = get_node("Savefiles/Save Slot 1")
@onready var _save1_active:bool = false
@onready var _save2:menu_button = get_node("Savefiles/Save Slot 2")
@onready var _save2_active:bool = false
@onready var _save3:menu_button = get_node("Savefiles/Save Slot 3")
@onready var _save3_active:bool = false

@onready var deletion_save: String = ""

func _ready():
	load_saves()
	SaveSystem.currentSave = ""
	SaveSystem.gameData = GameData.new()
	print("Current Save:",SaveSystem.currentSave)

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://Screens/main.tscn")
	
func load_saves():
	var save: GameData = GameData.new()
	if ResourceLoader.exists(SaveSystem.save_file_path + SaveSystem.saveList["save1"]):
		print("Save 1 Found")
		save = ResourceLoader.load(SaveSystem.save_file_path + SaveSystem.saveList["save1"])
		_save1.button_label.text = save.saveName
		_save1_active = true
		get_node("Delete Saves/Delete Save 1").visible = true
	else:
		print("Save 1 Not Found at " + SaveSystem.save_file_path + SaveSystem.saveList["save1"])
		_save1.button_label.text = "Save Slot #1"
	if ResourceLoader.exists(SaveSystem.save_file_path + SaveSystem.saveList["save2"]):
		print("Save 2 Found")
		save = load(SaveSystem.save_file_path + SaveSystem.saveList["save2"])
		_save2.button_label.text = save.saveName
		_save2_active = true
		get_node("Delete Saves/Delete Save 2").visible = true
	else:
		print("Save 2 Not Found at " + SaveSystem.save_file_path + SaveSystem.saveList["save2"])
		_save2.button_label.text = "Save Slot #2"
	if ResourceLoader.exists(SaveSystem.save_file_path + SaveSystem.saveList["save3"]):
		print("Save 3 Found")
		save = load(SaveSystem.save_file_path + SaveSystem.saveList["save3"])
		_save3.button_label.text = save.saveName
		_save3_active = true
		get_node("Delete Saves/Delete Save 3").visible = true
	else:
		print("Save 3 Not Found at " + SaveSystem.save_file_path + SaveSystem.saveList["save3"])
		_save3.button_label.text = "Save Slot #3"

func _on_save_slot_1_pressed():
	SaveSystem.currentSave = SaveSystem.saveList["save1"]
	print("Current Save:",SaveSystem.currentSave)
	use_save(_save1_active)

func _on_save_slot_2_pressed():
	SaveSystem.currentSave = SaveSystem.saveList["save2"]
	print("Current Save:",SaveSystem.currentSave)
	use_save(_save2_active)

func _on_save_slot_3_pressed():
	SaveSystem.currentSave = SaveSystem.saveList["save3"]
	print("Current Save:",SaveSystem.currentSave)
	use_save(_save3_active)

func use_save(active: bool):
	if active:
		SaveSystem.load_data(SaveSystem.currentSave)
		print("Loading Save:",SaveSystem.currentSave)
		get_tree().change_scene_to_file("res://Screens/game.tscn")
	else:
		print("Preparing New Save")
		get_tree().change_scene_to_file("res://Screens/new-game-screen.tscn")

#Debugg Code - Remove on release
func _on_new_pressed():
	get_tree().change_scene_to_file("res://Screens/new-game-screen.tscn")
func _on_intro_pressed():
	get_tree().change_scene_to_file("res://Screens/intro.tscn")
func _on_game_pressed():
	get_tree().change_scene_to_file("res://Screens/game.tscn")


func _on_delete_save_1_pressed():
	confirm_deletion(_save1.button_label.text,SaveSystem.save_file_path + SaveSystem.saveList["save1"])


func _on_delete_save_2_pressed():
	confirm_deletion(_save2.button_label.text,SaveSystem.save_file_path + SaveSystem.saveList["save2"])


func _on_delete_save_3_pressed():
	confirm_deletion(_save3.button_label.text,SaveSystem.save_file_path + SaveSystem.saveList["save3"])

func confirm_deletion(save_name: String,save_route: String):
	get_node("Delete Save Message/Border/Save Name").text = save_name
	deletion_save = save_route
	get_node("Delete Save Message").visible = true
	


func _on_confirm_pressed():
	if deletion_save:
		DirAccess.remove_absolute(deletion_save)
		deletion_save = ""
		get_tree().reload_current_scene()


func _on_cancel_pressed():
	deletion_save = ""
	get_node("Delete Save Message").visible = false
