extends Resource
class_name StarSystem

@export var starType = GlobalEnums.StarSystemType.YELLOW
@export var systemName: String = "System Name"
@export var starEnergy: float = 1
@export var totalBodies: int = 3
@export var bodyList: Array[CelestialBody]

var starEnergyChart: Dictionary = {
	"Barren": 0,
	"Red": 0.5,
	"Yellow": 1,
	"Blue": 1.5
}

func _init():
	systemName = randomName()
	var rng = randf_range(0,100)
	if rng <= 10.0:
		starType = GlobalEnums.StarSystemType.BARREN
		starEnergy = starEnergyChart["Barren"]
		newBarrenSystem()
	else:
		if rng > 10.0 && rng <= 30.0:
			var coin = randi_range(0,1)
			if coin == 0:
				starType = GlobalEnums.StarSystemType.RED
				starEnergy = starEnergyChart["Red"]
			else:
				starType = GlobalEnums.StarSystemType.BLUE
				starEnergy = starEnergyChart["Blue"]
		else:
			starType = GlobalEnums.StarSystemType.YELLOW
			starEnergy = starEnergyChart["Yellow"]
		newStarSystem(starType)

func randomName() -> String:
	return "System Name"

#Creates new barren system with 0 (40%), 1 (50%) or 2 (10%) asteroids
func newBarrenSystem():
	var bodyNumber = randf_range(0,100)
	if bodyNumber > 90:
		generateAsteroids(2)
	elif bodyNumber <= 40:
		generateAsteroids(0)
	else:
		generateAsteroids(1)

#Adds random asteroids to system
func generateAsteroids(amount: int):
	totalBodies = amount
	for i in range(amount):
		bodyList.append(CelestialBody.new(GlobalEnums.CelestialBodyType.ASTEROID))

#Creates new star system with 3 (60%), 2 (30%) or 1 (10%) planets
func newStarSystem(type):
	var bodyNumber = randf_range(0,100)
	if bodyNumber > 40:
		generatePlanets(3)
	elif bodyNumber <= 10:
		generatePlanets(1)
	else:
		generatePlanets(2)

#Generates list of planets for system
#60% chance of Rock
#35% chance of Gar, Ice or Ring
#5% chance for asteroid
func generatePlanets(amount: int):
	totalBodies = amount
	for i in range(amount):
		var bodyType = randf_range(0,100)
		if bodyType > 40:
			bodyList.append(CelestialBody.new(GlobalEnums.CelestialBodyType.ROCK))
		elif bodyType <= 5:
			bodyList.append(CelestialBody.new(GlobalEnums.CelestialBodyType.ASTEROID))
		else:
			var rng = randi_range(1,3)
			match rng:
				1:
					bodyList.append(CelestialBody.new(GlobalEnums.CelestialBodyType.RING))
				2:
					bodyList.append(CelestialBody.new(GlobalEnums.CelestialBodyType.ICE))
				3:
					bodyList.append(CelestialBody.new(GlobalEnums.CelestialBodyType.GAS))
