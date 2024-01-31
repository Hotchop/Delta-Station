extends Node2D



func _on_button_pressed():
	if !Game.skip_intro:
		get_tree().change_scene_to_file("res://Screens/intro.tscn")
	else:
		get_tree().change_scene_to_file("res://Screens/game.tscn")
