extends Node

var save_file_path = "user://save/"
var saveList: Dictionary ={
	"save1" = "PlayerSave1.tres",
	"save2" = "PlayerSave2.tres",
	"save3" = "PlayerSave3.tres"
}
var currentSave: String = ""
var gameData = GameData.new()

func _ready():
	verify_save_directory(save_file_path)

func verify_save_directory(path: String):
	DirAccess.make_dir_absolute(path)

func load_data(fileName: String):
	gameData = ResourceLoader.load(save_file_path + fileName)
	Game.date = gameData.date
	Game.stationResources = gameData.stationResources
	Game.currentSystem = gameData.currentSystem
	Game.nextSystem = gameData.nextSystem
	Game.futureSystem = gameData.futureSystem
	Game.modules = gameData.modules
	Game.difficulty = gameData.difficulty
	print("Load Succesful")
	for i in Game.modules.modules_array:
		print(i.moduleName+" - Hull:"+str(i.hull))

func save_data(fileName: String):
	gameData.date = Game.date
	gameData.stationResources = Game.stationResources
	gameData.currentSystem = Game.currentSystem
	gameData.nextSystem = Game.nextSystem
	gameData.futureSystem = Game.futureSystem
	gameData.modules = Game.modules
	gameData.difficulty = Game.difficulty
	ResourceSaver.save(gameData,save_file_path + fileName)
	print("Save Succesful")
	for i in gameData.modules.modules_array:
		print(i.moduleName+" - Hull:"+str(i.hull))
