extends CanvasLayer

func _process(_delta):
	get_node("HoveredModule").text = WorldUi.hovered_module_name
	get_node("HoveredModule/HoveredHull").text = WorldUi.hovered_module_hull
	get_node("Date/dayNumber").text = str(Game.date)
