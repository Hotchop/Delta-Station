extends Resource
class_name StationResourses

@export var energy: BasicResource
@export var battery: BasicResource
@export var food: BasicResource
@export var water: BasicResource
@export var oxigen: BasicResource
@export var nitrogen: BasicResource
@export var CO2: BasicResource
@export var metals: BasicResource

func generate_energy(value: float):
	if energy.is_available:
		if value + energy.stored > energy.MAX:
			var excess = value - (energy.MAX - energy.stored)
			energy.set("stored",energy.MAX)
			if battery.is_available:
				battery.change_amount(excess)
		else:
			energy.change_amount(value)

func consume_energy(value: float):
	if battery.is_available && battery.stored > 0:
		pass
