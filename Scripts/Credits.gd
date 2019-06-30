extends Panel

onready var quitButton = get_node("BackButton")

func _ready():
	quitButton.connect("pressed",self,"Back")
	quitButton.grab_focus()

func Back():
	get_tree().change_scene("Scenes/Menu.tscn")