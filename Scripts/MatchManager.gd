extends Node2D

onready var player1 = get_node("Player1")
onready var player2 = get_node("Player2")

var currentTurnPlayer

func _ready():
	player1.startPositions.append(Vector2(-350, 200))
	player1.startPositions.append(Vector2(-350, -200))
	player1.startPositions.append(Vector2(-250, 100))
	player1.startPositions.append(Vector2(-250, -100))
	player1.startPositions.append(Vector2(-150, 0))
		
	player2.startPositions.append(Vector2(-350, 250))
	player2.startPositions.append(Vector2(-450, -200))
	player2.startPositions.append(Vector2(-250, 150))
	player2.startPositions.append(Vector2(-550, -100))
	player2.startPositions.append(Vector2(-150, 0))
	
	player1.SpawnButtons()
	player2.SpawnButtons()
	
	currentTurnPlayer = player1
		
	pass 
	
func _process(delta):
	if Input.is_action_just_pressed("ui_select"):
		PassTurn()
		
	print(currentTurnPlayer.name)
	pass
	
func PassTurn():
	if currentTurnPlayer == player1:
		currentTurnPlayer = player2
	else:
		currentTurnPlayer = player1
	
	pass
