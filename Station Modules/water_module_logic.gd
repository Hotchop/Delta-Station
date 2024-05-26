extends TextureButton

const MAX_SPRITE_HEIGHT = 15
const MIN_SPRITE_HEIGHT = 70
@onready var sprite: AnimatedSprite2D = get_node("Clip Mask/Water Sprite")

func _process(_delta):
	water_positon(Game.stationResources.water)

func water_positon(water: BasicResource):
	var new_position: float = (water.stored * (MIN_SPRITE_HEIGHT - MAX_SPRITE_HEIGHT)) / 100
	sprite.position = Vector2(0,MIN_SPRITE_HEIGHT - new_position)
