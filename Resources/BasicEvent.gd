extends Resource
class_name BasicEvent

@export var title: String
@export_multiline var description
@export_file("*.png") var logo
@export_enum("Reward","Choise","Hazard") var event_type: String
@export var option1_text: String
@export var option2_text: String
@export_multiline var outcome1: String
@export_multiline var outcome2: String
