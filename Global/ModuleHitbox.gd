extends TextureButton


func _on_mouse_entered():
	var module_name = get_parent().name
	WorldUi.change_hover_name(module_name)

func _on_mouse_exited():
	WorldUi.change_hover_name("")
