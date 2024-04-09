extends Resource
class_name CelestialBody

const MAX_VALUE: float = 60.0
const MIN_VALUE: float = 0.0
const LOW_RANGE: float = 10.0
const MID_RANGE: float = 20.0
const HIGH_RANGE: float = 40.0

var quality: Dictionary = {
	"None": MIN_VALUE,
	"Poor": LOW_RANGE,
	"Good": MID_RANGE,
	"Great": HIGH_RANGE
}

@export var bodyType = GlobalEnums.CelestialBodyType.ROCK
@export var bodyName: String = "Body Name"
@export var probeTime: int = 5
@export var food: BasicResource = BasicResource.new()
@export var water: BasicResource = BasicResource.new()
@export var O2: BasicResource = BasicResource.new()
@export var metal: BasicResource = BasicResource.new()

#Init only accepts the Enum type GlobalEnums.CelestialBodyType
func _init(type = GlobalEnums.CelestialBodyType.ROCK,name: String = "Planet"):
	bodyType = type
	bodyName = name
	match type:
		GlobalEnums.CelestialBodyType.ASTEROID:
			newAsteroid()
		GlobalEnums.CelestialBodyType.GAS: 
			newGas()
		GlobalEnums.CelestialBodyType.ICE: 
			newIce()
		GlobalEnums.CelestialBodyType.RING: 
			newRing()
		GlobalEnums.CelestialBodyType.ROCK: 
			newRock()

func generateResourse(baseValue: float) -> float:
	match baseValue:
		LOW_RANGE:
			return randf_range(LOW_RANGE,MID_RANGE)
		MID_RANGE:
			return randf_range(MID_RANGE,HIGH_RANGE)
		HIGH_RANGE:
			return randf_range(HIGH_RANGE,MAX_VALUE)
		_:
			return 0

func newAsteroid():
	probeTime = 1
	food.stored = generateResourse(quality["None"])
	water.stored = generateResourse(quality["None"])
	O2.stored = generateResourse(quality["None"])
	metal.stored = generateResourse(quality["Great"])
	

func newGas():
	probeTime = randi_range(2,3)
	food.stored = generateResourse(quality["None"])
	water.stored = generateResourse(quality["None"])
	O2.stored = generateResourse(quality["Great"])
	metal.stored = generateResourse(quality["None"])

func newIce():
	probeTime = randi_range(2,3)
	food.stored = generateResourse(quality["None"])
	water.stored = generateResourse(quality["Great"])
	O2.stored = generateResourse(quality["None"])
	metal.stored = generateResourse(quality["None"])

func newRing():
	probeTime = randi_range(2,3)
	food.stored = generateResourse(quality["None"])
	match randi_range(1,3):
		1:
			water.stored = generateResourse(quality["Good"])
			O2.stored = generateResourse(quality["Good"])
			metal.stored = generateResourse(quality["None"])
		2:
			water.stored = generateResourse(quality["Good"])
			O2.stored = generateResourse(quality["None"])
			metal.stored = generateResourse(quality["Good"])
		3:
			water.stored = generateResourse(quality["None"])
			O2.stored = generateResourse(quality["Good"])
			metal.stored = generateResourse(quality["Good"])

func newRock():
	probeTime = randi_range(3,5)
	food.stored = generateResourse(quality["Great"])
	water.stored = generateResourse(quality["Good"])
	O2.stored = generateResourse(quality["Good"])
	metal.stored = generateResourse(quality["Poor"])
