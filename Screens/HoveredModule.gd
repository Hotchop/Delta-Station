extends Label

func _process(_delta):
	self.text = WorldUi.hovered_module_name
