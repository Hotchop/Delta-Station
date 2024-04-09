extends Node2D

const MAX_HULL: float = 100

@export var module: ModuleStats
@export var hull: float = MAX_HULL
@export var destroyed: bool = false
signal is_destroyed

func _process(_delta):
	update_sprite_with_hp()
	if module:
		hull = module.hull
		if hull < 0:
			destroy()
	

#func start_damaged(modifier):
	#var minHull = (MAX_HULL * modifier)-10
	#var rng = RandomNumberGenerator.new()
	#var damage = MAX_HULL - rng.randf_range(minHull,MAX_HULL)
	#damage_hull(damage)
	#print("Damaged ",get_parent().name," for ",snapped(damage,0.1),". Current Hull ",snapped(hull,0.1))
#
#func repair_hull(amount: float):
	#hull += amount
	#if hull > MAX_HULL:
		#hull = MAX_HULL
#
#func damage_hull(amount: float):
	#hull -= amount
	#if hull <= 0:
		#destroy()
		#
func destroy():
	hull = 0
	destroyed = true
	get_tree().queue_delete(get_parent())
	is_destroyed.emit()
	
func update_sprite_with_hp():
	var anim = get_node("../AnimatedSprite2D")
	if hull > 75:
		anim.animation = "100"
	elif 50 < hull && hull <= 75:
		anim.animation = "75"
	elif 25 < hull && hull <= 50:
		anim.animation = "50"
	else:
		anim.animation = "25"

