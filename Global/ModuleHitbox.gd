extends TextureButton

var cursor_h = preload("res://Assets/UI/Cursor-Hover.png")

func _ready():
	Input.set_custom_mouse_cursor(cursor_h,Input.CURSOR_POINTING_HAND,Vector2(0,0))

func _on_mouse_entered():
	var module_name = get_parent().name
	var module_hull = get_node("../HullComponent").hull
	WorldUi.change_hover_name(module_name)
	WorldUi.change_hover_hull(str(snapped(module_hull,0.1),"%"))

func _on_mouse_exited():
	WorldUi.change_hover_name("")
	WorldUi.change_hover_hull("")
