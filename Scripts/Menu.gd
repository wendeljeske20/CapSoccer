extends Panel

onready var startButton = get_node("StartButton")
func _ready():
	startButton.connect("pressed",self,"Teste")
	
func Teste():
	get_tree().change_scene("Scenes/Match.tscn")

