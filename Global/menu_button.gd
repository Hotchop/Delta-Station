extends TextureButton

@export var button_text = "Text"
@export var button_label: Label
@export_enum("Left","Center","Right","Fill") var aligment = "Center"

func _ready():
	button_label.text = button_text
	align_text()

func align_text():
	match aligment:
		"Left":
			button_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
		"Right":
			button_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
		"Fill":
			button_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_FILL
		"Center":
			button_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
