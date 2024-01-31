extends Node2D
@onready var dif: TextureButton = $"Difficulty/Normal Option"
@onready var group:ButtonGroup = dif.button_group
@onready var description: RichTextLabel = $Difficulty/Description

func _ready():
	dif.button_pressed = true
	
func _process(_delta):
	if dif.name != group.get_pressed_button().name:
		dif = group.get_pressed_button()
		match dif.name:
			"Easy Option":
				Game.difficulty = Game.difficultyList["Easy"]
				description.text = "[center][b]Easy Mode[/b]
Recomended for first time players
All modules start at full health"
			"Normal Option":
				Game.difficulty = Game.difficultyList["Normal"]
				description.text = "[center][b]Normal Mode[/b]
Standar game mode
Some modules may start a bit damaged"
			"Hard Option":
				Game.difficulty = Game.difficultyList["Hard"]
				description.text = "[center][b]Hard Mode[/b]
Recomended for experienced players
More modules are damaged at start
Damage is more severe"
			"Voided Option":
				Game.difficulty = Game.difficultyList["Voided"]
				description.text = "[center][b]Voided Mode[/b]
Ultimate challenge
All modules start damaged
Some modules may be destroyed from the start"


func _on_menu_button_pressed():
	get_tree().change_scene_to_file("res://Screens/saves-screen.tscn")


func _on_tutorial_toggle_toggled(toggled_on):
	if toggled_on:
		Game.skip_tutorial = true
	else:
		Game.skip_tutorial = false

func _on_intro_toggle_toggled(toggled_on):
	if toggled_on:
		Game.skip_intro = true
	else:
		Game.skip_intro = false


func _on_start_pressed():
	$"Extra Settings/Scene Transition/AnimationPlayer".play("fade_out")

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "fade_out":
		if !Game.skip_tutorial:
			get_tree().change_scene_to_file("res://Screens/tutorial.tscn")
		elif !Game.skip_intro:
			get_tree().change_scene_to_file("res://Screens/intro.tscn")
		else:
			get_tree().change_scene_to_file("res://Screens/game.tscn")
			
