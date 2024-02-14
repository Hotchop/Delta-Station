extends Node

const DATE_START = 0
var date = DATE_START
var currentSystem: StarSystem
var nextSystem: StarSystem
var difficultyList: Dictionary = {
	"Easy": 1,
	"Normal": 0.7,
	"Hard": 0.5,
	"Voided": 0
}
var difficulty = difficultyList["Normal"]
@onready var skip_tutorial: bool = false
@onready var skip_intro: bool = false

func game_start():
	if date == 0:
		_first_system()

func next_day():
	date += 1
	warp_system()

#Star System Generator
func _first_system():
	currentSystem = StarSystem.new()
	nextSystem = StarSystem.new()
	
func warp_system():
	currentSystem = nextSystem
	nextSystem = StarSystem.new()
