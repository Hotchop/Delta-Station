extends CanvasLayer

func _process(_delta):
	get_node("HoveredModule").text = WorldUi.hovered_module_name
	get_node("HoveredModule/HoveredHull").text = WorldUi.hovered_module_hull
	get_node("Date/dayNumber").text = str(Game.date)
	update_connector_sprites()
	
func update_connector_sprites():
	var station = get_node("../Station Parts")
	
	#Connector 1
	if !station.has_node("../Station Parts/Reactor") && !station.has_node("../Station Parts/Materials"):
		get_node("Connectors/Connector1-reactor-materials").visible = false
		
	#Connector 2
	if !station.has_node("../Station Parts/Materials") && !station.has_node("../Station Parts/Battery"):
		get_node("Connectors/Connector2-materials-battery").visible = false
		
	#Connector 3
	if !station.has_node("../Station Parts/Battery") && !station.has_node("../Station Parts/Atmosphere Generator"):
		get_node("Connectors/Connector3-battery-atmosphere").visible = false
		
	#Connector 4
	if !station.has_node("../Station Parts/Atmosphere Generator") && !station.has_node("../Station Parts/Biosphere"):
		get_node("Connectors/Connector4-atmosphere-biosphere").visible = false
		
	#Connector 5
	if !station.has_node("../Station Parts/Biosphere") && !station.has_node("../Station Parts/Gravity Ring"):
		get_node("Connectors/Connector5-biosphere-ring").visible = false
