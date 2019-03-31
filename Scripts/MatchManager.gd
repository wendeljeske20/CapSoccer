extends Node2D

onready var player1 = get_node("Player1")
onready var player2 = get_node("Player2")

onready var currentPlayer = player1
onready var matchTimer = get_node("HudManager/ScorePanel/MatchTimer")
onready var timeLabel = get_node("HudManager/ScorePanel/TimeLabel")


# Input Section
var inputRight = 0
var inputLeft = 0
var inputUp = 0
var inputDown = 0
var movementDirection = Vector2()

func _ready():
	player1.startPositions.append(Vector2(-200, 200))
	player1.startPositions.append(Vector2(0, 200))
	player1.startPositions.append(Vector2(200, 200))
		
	player2.startPositions.append(Vector2(-200, -200))
	player2.startPositions.append(Vector2(0, -200))
	player2.startPositions.append(Vector2(200, -200))
	
	player1.SpawnButtons()
	player2.SpawnButtons()
	
	#currentTurnPlayer = player1
	pass 
	
func _process(delta):
	ProcessInput()
	currentPlayer.SetCurrentButton(movementDirection.angle())
	
	
	if matchTimer.time_left <= 0:
		PassTurn()
		
		
	timeLabel.set_text(str(int(round(matchTimer.get_time_left()))))
	pass
	
func PassTurn():
	if currentPlayer == player1:
		currentPlayer = player2
	else:
		currentPlayer = player1
	matchTimer.start();
	pass

func ProcessInput():
	var currentController = "controller"+currentPlayer.playerID
	
	inputRight = Input.get_action_strength(currentController+"_right")
	inputLeft = Input.get_action_strength(currentController+"_left");
	inputUp = Input.get_action_strength(currentController+"_up");
	inputDown = Input.get_action_strength(currentController+"_down");
	
	if(Input.is_action_just_pressed(currentController+"_lb")):
		currentPlayer.CycleCurrentButton(-1)
	if(Input.is_action_just_pressed(currentController+"_rb")):
		currentPlayer.CycleCurrentButton(1)
	#if(Input.is_action_just_pressed(currentController+"_rb")):
	#	PassTurn()
	
	movementDirection.x = inputRight - inputLeft
	movementDirection.y = inputUp - inputDown