extends Node2D

var text

func _ready():
	text = get_node("Intro Text")
	text.visible_ratio = 0

func _process(delta):
	if text.visible_ratio < 1:
		text.visible_ratio += delta * 0.2
	if Input.is_anything_pressed():
		text.visible_ratio = 1
	if Input.is_key_pressed(KEY_Y):
		get_tree().change_scene_to_file("res://Screens/game.tscn")
	elif Input.is_key_pressed(KEY_N):
			get_tree().quit()
