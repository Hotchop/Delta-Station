extends Node2D

var card = preload("res://Star System/planet_card.tscn")
var buttonGroup: ButtonGroup = preload("res://Settings/planet_card_button_group.tres")

func _ready():
	get_current_system()
	get_next_system()

func _process(_delta):
	if GlobalFlags.view_current_system == true:
		get_node("Current").visible = true
		get_node("Next").visible = false
	else:
		get_node("Current").visible = false
		get_node("Next").visible = true

func get_current_system():
	var posX
	var posY = 192
	var total: int = Game.currentSystem.totalBodies
	get_node("System Name").text = Game.currentSystem.systemName
	var node: Node2D = get_node("Current")
	if total != 0:
		get_node("Empty System").visible = false
	match total:
		0:
			get_node("Empty System").visible = true
		1:
			posX = 822
			var planetCard = card.instantiate()
			planetCard.get_data(Game.currentSystem.bodyList[0])
			planetCard.position = Vector2(posX,posY)
			node.add_child(planetCard)
		2:
			posX = 576
			for i in range(2):
				var planetCard = card.instantiate()
				planetCard.get_data(Game.currentSystem.bodyList[i])
				planetCard.position = Vector2(posX,posY)
				node.add_child(planetCard)
				posX += 512

		3:
			posX = 318
			for i in range(3):
				var planetCard = card.instantiate()
				planetCard.get_data(Game.currentSystem.bodyList[i])
				planetCard.position = Vector2(posX,posY)
				node.add_child(planetCard)
				posX += 504
	var button: TextureButton
	buttonGroup.pressed.connect(_on_buttonGroup_pressed)
	for i in get_node("Current").get_children():
		button = i.get_child(5)
		button.button_group = buttonGroup

func get_next_system():
	pass

func _on_buttonGroup_pressed(button: BaseButton):
	var selectedCard: Node2D = button.get_parent()
	for i in buttonGroup.get_buttons():
		i.disabled = true
	var anim: AnimatedSprite2D = selectedCard.get_node("Planet Animation")
	anim.animation_finished.connect(_on_animation_finished)
	anim.play()
	
func _on_animation_finished():
	get_tree().change_scene_to_file("res://Screens/game.tscn")

func _on_reload_pressed():
	Game.next_day()
	get_tree().reload_current_scene()


func _on_back_arrow_pressed():
	get_tree().change_scene_to_file("res://Screens/game.tscn")
