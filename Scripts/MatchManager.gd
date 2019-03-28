extends Node2D

onready var player1 = get_node("Player1")
onready var player2 = get_node("Player2")

onready var currentTurnPlayer = player1
onready var matchTimer = get_node("MatchTimer")
onready var timeLabel = get_node("TimeLabel")

func _ready():
	player1.startPositions.append(Vector2(-650, 200))
	player1.startPositions.append(Vector2(-350, -200))
	player1.startPositions.append(Vector2(-250, 100))
		
	player2.startPositions.append(Vector2(-350, 250))
	player2.startPositions.append(Vector2(-450, -200))
	player2.startPositions.append(Vector2(-250, 150))
	
	player1.SpawnButtons()
	player2.SpawnButtons()
	
	#currentTurnPlayer = player1
	pass 
	
func _process(delta):
	if Input.is_action_just_pressed("ui_page_down"):
		PassTurn()
		#player1.ResetButtonPositions()
		
	timeLabel.set_text(str(int(matchTimer.get_time_left())))
	#print(matchTimer.get_time_left())
	pass
	
func PassTurn():
	if currentTurnPlayer == player1:
		currentTurnPlayer = player2
	else:
		currentTurnPlayer = player1
	
	pass
