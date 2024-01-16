extends CanvasLayer



func _on_quit_button_db_pressed():
	get_tree().quit()



func _on_next_day_db_pressed():
	Game.next_day()
