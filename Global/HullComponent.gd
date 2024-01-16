extends Node2D

const MAX_HULL: float = 100

@export var hull: float = MAX_HULL
@export var destroyed: bool = false
@export var anim: AnimatedSprite2D
signal is_destroyed

func _process(_delta):
	update_sprite_with_hp()
	if hull < 0:
		destroy()

func start_damaged(modifier):
	var minHull = (MAX_HULL * modifier)-10
	var rng = RandomNumberGenerator.new()
	var damage = MAX_HULL - rng.randf_range(minHull,MAX_HULL)
	damage_hull(damage)
	print("Damaged ",get_parent().name," for ",snapped(damage,0.1),". Current Hull ",snapped(hull,0.1))

func repair_hull(amount: float):
	hull += amount
	if hull > MAX_HULL:
		hull = MAX_HULL

func damage_hull(amount: float):
	hull -= amount
	if hull <= 0:
		destroy()
		
func destroy():
	hull = 0
	destroyed = true
	is_destroyed.emit()
	
func update_sprite_with_hp():
	if range(75,100).has(hull):
		anim.play("100")
	if range(50,75).has(hull):
		anim.play("75")
	if range(25,50).has(hull):
		anim.play("50")
	if range(0,25).has(hull):
		anim.play("25")
