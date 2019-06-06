extends Node

export(int) var aaa = 10

onready var restartButton = get_node("RestartButton")
onready var arenaSelectButton = get_node("ArenaSelectButton")
onready var menuButton = get_node("MenuButton")



#export(MATCH_END) var match_end



func _ready():
	restartButton.connect("pressed",self,"Restart")
	restartButton.grab_focus()
	arenaSelectButton.connect("pressed",self,"ArenaSelect")
	arenaSelectButton.grab_focus()
	menuButton.connect("pressed",self,"Menu")
	menuButton.grab_focus()
	
	
func Restart():
	get_tree().change_scene("Scenes/Match.tscn")

func ArenaSelect():
	get_tree().change_scene("Scenes/ArenaSelect.tscn")
	
func Menu():
	get_tree().change_scene("Scenes/Menu.tscn")
