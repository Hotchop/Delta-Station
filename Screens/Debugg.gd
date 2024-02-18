extends CanvasLayer



func _on_quit_button_db_pressed():
	get_tree().quit()



func _on_next_day_db_pressed():
	Game.next_day()


func _on_damage_hull_pressed():
	for j in get_node("../Station Parts").get_children():
		var child = j.get_node("HullComponent")
		if child.has_method("damage_hull"):
			child.damage_hull(10)


func _on_reset_pressed():
	get_tree().reload_current_scene()


func _on_current_system_pressed():
	GlobalFlags.view_current_system = true
	get_tree().change_scene_to_file("res://Screens/system_cards.tscn")


func _on_next_system_pressed():
	GlobalFlags.view_current_system = true
	get_tree().change_scene_to_file("res://Screens/system_cards.tscn")
