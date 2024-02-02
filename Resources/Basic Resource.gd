extends Resource
class_name BasicResource

const MAX: float = 100
const MIN: float = 0
@export var stored: float
@export var is_available: bool

func _init(r_stored = 0,r_available = true):
	stored = r_stored
	is_available = r_available

func change_amount(amount: float):
	if is_available:
		stored += amount
		if stored >= MAX:
			stored = MAX
		if stored <= MIN:
			stored = MIN
