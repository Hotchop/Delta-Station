extends Node

const DATE_START = 0
var date = DATE_START
var stationResources: StationResourses
var currentSystem: StarSystem
var nextSystem: StarSystem
var difficultyList: Dictionary = {
	"Easy": 1,
	"Normal": 0.7,
	"Hard": 0.5,
	"Voided": 0
}
var difficulty = difficultyList["Normal"]
@onready var skip_tutorial: bool = false	#Move to Global Flags
@onready var skip_intro: bool = false	#Move to Global Flags

var greekLetterList: Array = []
var constellationList: Array = []
var greek_list_path = "res://Assets/json/greek_letters.json"
var constellation_list_path = "res://Assets/json/constellations.json"

var cursor_h = preload("res://Assets/UI/Cursor-Hover.png")
signal nextDay

func _ready():
	Input.set_custom_mouse_cursor(cursor_h,Input.CURSOR_POINTING_HAND,Vector2(0,0))
	greekLetterList = load_name_files(greek_list_path)
	constellationList = load_name_files(constellation_list_path)
	game_start()

func game_start():
	if date == 0:
		_first_system()

func next_day():
	date += 1
	warp_system()
	stationResources.probe_daily_check()
	nextDay.emit()

#Star System Generator
func _first_system():
	currentSystem = StarSystem.new()
	nextSystem = StarSystem.new()
	stationResources = StationResourses.new(difficulty)
	
func warp_system():
	currentSystem = nextSystem
	nextSystem = StarSystem.new()

func load_name_files(filepath: String):
	if FileAccess.file_exists(filepath):
		var datafile = FileAccess.open(filepath,FileAccess.READ)
		var parsedResult = JSON.parse_string(datafile.get_as_text())
		if parsedResult is Array:
			return parsedResult
		else:
			print("Error reading file")
	else:
		print("Error: File doesn't exist at "+ filepath)

