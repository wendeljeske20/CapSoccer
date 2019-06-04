extends Panel

onready var backButton = get_node("BackButton")

func _ready():
	backButton.connect("pressed",self,"Back")
	backButton.grab_focus()
	
func Back():
	get_tree().change_scene("Scenes/Menu.tscn")
	

