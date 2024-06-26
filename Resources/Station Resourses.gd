extends Resource
class_name StationResourses

@export var energy: BasicResource
@export var battery: BasicResource
@export var food: BasicResource
@export var water: BasicResource
@export var oxigen: BasicResource
@export var metals: BasicResource
@export var probe_dispatched: bool
@export var observer_activated: bool
@export var gravity_activated: bool
@export var consumption: float
@export var probeData: ProbeData
var resource_list: Array[BasicResource] = [energy,battery,food,water,oxigen,metals]

func starting_values(difficulty: float):
	energy = BasicResource.new(100*randf_range(difficulty,1),true)
	battery = BasicResource.new(0.0,true)
	food = BasicResource.new(100*randf_range(difficulty,1),true)
	water = BasicResource.new(100*randf_range(difficulty,1),true)
	oxigen = BasicResource.new(100*randf_range(difficulty,1),true)
	metals = BasicResource.new(100*randf_range(difficulty,1),true)
	probe_dispatched = false
	observer_activated = false
	gravity_activated = false
	consumption = 25.0
	print("Starting Energy: "+str(energy.stored))
	print("Starting Battery: "+str(battery.stored))
	print("Starting Food: "+str(food.stored))
	print("Starting Water: "+str(water.stored))
	print("Starting O2: "+str(oxigen.stored))
	print("Starting Metal: "+str(metals.stored))

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
		if value <= battery.stored:
			battery.change_amount(-value)
		else:
			var excess = value - battery.stored
			battery.set("stored",battery.MIN)
			energy.change_amount(-excess)
	else:
		if value > energy.stored:
			print("Not enoguth energy")
			return
		else:
			energy.change_amount(-value)

func lauch_probe(data: CelestialBody):
	probeData = ProbeData.new(data)
	probe_dispatched = true

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
			
