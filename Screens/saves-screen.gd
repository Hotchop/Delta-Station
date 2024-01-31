extends Node2D

func _ready():
	var _save1 = get_node("Savefiles/Save Slot 1")
	var _save2 = get_node("Savefiles/Save Slot 2")
	var _save3 = get_node("Savefiles/Save Slot 3")


func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://Screens/main.tscn")


#Debugg Code - Remove on release
func _on_new_pressed():
	get_tree().change_scene_to_file("res://Screens/new-game-screen.tscn")
func _on_intro_pressed():
	get_tree().change_scene_to_file("res://Screens/intro.tscn")
func _on_game_pressed():
	get_tree().change_scene_to_file("res://Screens/game.tscn")
