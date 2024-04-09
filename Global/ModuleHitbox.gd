extends TextureButton


func _on_mouse_entered():
	var module_name = get_parent().name
	var module_hull = get_node("../Station Module").hull
	WorldUi.change_hover_name(module_name)
	WorldUi.change_hover_hull(str(snapped(module_hull,0.1),"%"))

func _on_mouse_exited():
	WorldUi.change_hover_name("")
	WorldUi.change_hover_hull("")
