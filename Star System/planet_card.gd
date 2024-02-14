extends Node2D

var bodyData: CelestialBody

func _init(newBody: CelestialBody):
	bodyData = newBody;
	
# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Planet Name").text = bodyData.bodyName
	var description = "//Resources Detected
//Food: %d%%" % bodyData.food
#"//Water: %d%%" % bodyData.water
#"//O2: %d%%" % bodyData.food
#"//Metals: %d%%" % bodyData.food
#
#//Exploration Days: 5"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
