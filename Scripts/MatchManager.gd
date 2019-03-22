extends Node2D


var buttonPreload = preload("res://Scenes/Node2D.tscn")
var team1Buttons = []


var team1StartPositions = []

func _ready():
	
	team1StartPositions.append(Vector2(-350, 200))
	team1StartPositions.append(Vector2(-350, -200))
	team1StartPositions.append(Vector2(-250, 100))
	team1StartPositions.append(Vector2(-250, -100))
	team1StartPositions.append(Vector2(-150, 0))
	
	
		
	for i in range(0, 5):
		var button = buttonPreload.instance()
		get_node("../MatchManager").add_child(button)
		team1Buttons.append(button)
		team1Buttons[i].position = team1StartPositions[i]
		pass
		
		
	
	
		
	
	
	
	


	pass 
	
func _process(delta):
	for i in range(0, 5):
		print(team1Buttons[i].position)
		pass
	pass
