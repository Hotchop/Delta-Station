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
