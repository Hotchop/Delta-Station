extends Node2D


func _on_area_2d_mouse_entered():
	Cursor.hover_cursor()
	


func _on_area_2d_mouse_exited():
	Cursor.default_cursor()
