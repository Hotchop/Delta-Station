extends Resource
class_name ProbeData

@export var destination: CelestialBody
@export var time: int

func _init(data: CelestialBody):
	destination = data
	time = data.probeTime
