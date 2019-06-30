extends Node

onready var restartButton = get_node("RestartButton")
onready var arenaSelectButton = get_node("ArenaSelectButton")
onready var menuButton = get_node("MenuButton")
onready var winnerLabel = get_node("WinnerLabel")

func _ready():
	UI_Audios.playEndGame()
	
	restartButton.connect("pressed",self,"Restart")
	restartButton.grab_focus()
	arenaSelectButton.connect("pressed",self,"ArenaSelect")
	arenaSelectButton.grab_focus()
	menuButton.connect("pressed",self,"Menu")
	menuButton.grab_focus()
	
	if(MatchParameters.winner == 3):
		winnerLabel.text = "Empate!"
	elif(MatchParameters.winner == 2):
		winnerLabel.text = "Jogador 2 venceu!"
	elif(MatchParameters.winner == 1):
		winnerLabel.text = "Jogador 1 venceu!"

func Restart():
	get_tree().change_scene("Scenes/Match.tscn")

func ArenaSelect():
	get_tree().change_scene("Scenes/ArenaSelect.tscn")

func Menu():
	get_tree().change_scene("Scenes/Menu.tscn")
