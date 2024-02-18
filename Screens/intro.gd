extends Node2D

var text: Label
var input_text: Label
var allow_input = false

func _ready():
	text = get_node("Intro Text")
	input_text = get_node("Input Text")
	text.visible_ratio = 0
	input_text.visible_ratio = 0

func _process(delta):
	if text.visible_ratio < 1:
		text.visible_ratio += delta * 0.06
	else:
		if input_text.visible_ratio < 1:
			input_text.visible_ratio += delta * 0.6
		else:
			allow_input = true
	if Input.is_anything_pressed():
			text.visible_ratio = 1
	if allow_input == true:
			if Input.is_key_pressed(KEY_Y):
				$"Scene Transition/AnimationPlayer".play("fade_out")
			elif Input.is_key_pressed(KEY_N):
				get_tree().quit()


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "fade_out":
		get_tree().change_scene_to_file("res://Screens/game.tscn")
