extends Resource
class_name StationResourses

@export var energy: BasicResource
@export var battery: BasicResource
@export var food: BasicResource
@export var water: BasicResource
@export var oxigen: BasicResource
@export var metals: BasicResource
@export var probe_dispatched: bool = false
@export var probeData: ProbeData

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

func probe_daily_check():
	if probe_dispatched:
		probeData.time -= 1
		if probeData.time == 0:
			food.change_amount(probeData.destination.food.stored)
			water.change_amount(probeData.destination.water.stored)
			oxigen.change_amount(probeData.destination.O2.stored)
			metals.change_amount(probeData.destination.metal.stored)
			probeData.destination = null
			probe_dispatched = false
			
