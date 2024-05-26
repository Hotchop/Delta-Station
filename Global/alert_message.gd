extends Control

signal confirm_alert(confirm_string,confirm_value)

@export var message: String
@export_multiline var info: String
@export var confirm_string: String
@export var confirm_value: float

func _ready():
	get_node("Border/Message").text = message
	get_node("Border/Info").text = info
	set_data("",0)
	
func set_info(new_msg: String, new_info: String):
	get_node("Border/Message").text = new_msg
	get_node("Border/Info").text = new_info

func set_data(string: String, value: float):
	confirm_string = string
	confirm_value = value

func _on_confirm_pressed():
	confirm_alert.emit(confirm_string,confirm_value)
	$".".visible = false

func _on_cancel_pressed():
	$".".visible = false
