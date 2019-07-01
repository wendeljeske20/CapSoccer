extends Control

func _ready():
	Reset()

func Reset():
	if !ShaderController.shaderOn:
		hide()
	else:
		show()