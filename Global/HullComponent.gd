extends Node2D

const MAX_HULL: float = 100

@export var module: NodePath
@export var hull: float = MAX_HULL
@export var destroyed: bool = false
signal is_destroyed


func repair_hull(amount: float):
	hull += amount
	if hull > MAX_HULL:
		hull = MAX_HULL

func damage_hull(amount: float):
	hull -= amount
	if hull <= 0:
		destroyed = true
		is_destroyed.emit()
