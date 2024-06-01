extends Control

class_name Resourse_Bar

var resource_name: String
var amount: float
var resource_obj: BasicResource
@onready var bar: TextureProgressBar = $Bar
@onready var info_label: Label = $Info

func _ready():
	set_data(resource_name,amount)

func set_data(info:String,new_amount:float):
	resource_name = info
	amount = new_amount
	bar.value = new_amount
	info_label.text = info+" "+str(snapped(new_amount,0.1))+"%"

