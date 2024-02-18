extends Node2D

var bodyData: CelestialBody
var foodSTR: String
var waterSTR: String
var O2STR: String
var metalSTR: String
var timeSTR: String
var anim: AnimatedSprite2D


func get_data(newBody: CelestialBody):
	bodyData = newBody
	anim = get_node("Planet Animation")
	foodSTR =  str("%1.0f"%bodyData.food.stored)+"%"
	waterSTR = str("%1.0f"%bodyData.water.stored)+"%"
	O2STR = str("%1.0f"%bodyData.O2.stored)+"%"
	metalSTR = str("%1.0f"%bodyData.metal.stored)+"%"
	timeSTR = str(bodyData.probeTime)
	match bodyData.bodyType:
		GlobalEnums.CelestialBodyType.ASTEROID:
			anim.animation = "Asteroid"
		GlobalEnums.CelestialBodyType.GAS:
			anim.animation = "Gas"
		GlobalEnums.CelestialBodyType.ICE:
			anim.animation = "Ice"
		GlobalEnums.CelestialBodyType.RING:
			anim.animation = "Ring"
		GlobalEnums.CelestialBodyType.ROCK:
			anim.animation = "Rock"
	var label: Label = get_node("Planet Name")
	label.text = bodyData.bodyName
		
	get_node("Planet Resources").text = "//Resources Detected
	//Food: "+foodSTR+"
	//Water: "+waterSTR+"
	//O2: "+O2STR+"
	//Metals: "+metalSTR+"
	\n//Exploration Days: "+timeSTR


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

