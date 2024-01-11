extends Node


var cursor = preload("res://Assets/UI/Cursor.png")
var cursor_h = preload("res://Assets/UI/Cursor-Hover.png")

func default_cursor():
	Input.set_custom_mouse_cursor(cursor,Input.CURSOR_ARROW,Vector2(20,20))
	print("Cursor")
	
func hover_cursor():
	Input.set_custom_mouse_cursor(cursor_h,Input.CURSOR_ARROW,Vector2(20,20))
	print("Hover")
