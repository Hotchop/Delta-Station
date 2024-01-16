extends Node2D

var startDamagedModules = []

func _ready():
	difficulty_mod()

func difficulty_mod():
	difficulty_damage()

func difficulty_damage():
	var rng = RandomNumberGenerator.new()
	var value
	if Game.difficulty != Game.difficultyList["Easy"]:
		var modules = get_children()
		for i in modules:
			value = rng.randf_range(0,1)
			if value >= Game.difficulty:
				startDamagedModules.append(i)
		for j in startDamagedModules:
			var child = j.get_node("HullComponent")
			if child.has_method("start_damaged"):
				child.start_damaged(Game.difficulty)
