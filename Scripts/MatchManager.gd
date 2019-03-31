extends Node2D

onready var player1 = get_node("Player1")
onready var player2 = get_node("Player2")

onready var currentPlayer = player1
onready var matchTimer = get_node("MatchTimer")
onready var timeLabel = get_node("TimeLabel")

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
	
	if Input.is_action_just_pressed("ui_page_down"):
		PassTurn()
		#player1.ResetButtonPositions()
		
	timeLabel.set_text(str(int(matchTimer.get_time_left())))
	#print(matchTimer.get_time_left())
	pass
	
func PassTurn():
	if currentPlayer == player1:
		currentPlayer = player2
	else:
		currentPlayer = player1
	
	pass

func ProcessInput():
	var currentController = "controller"+currentPlayer.playerID
	print(currentController)
	inputRight = Input.get_action_strength(currentController+"_right")
	inputLeft = Input.get_action_strength(currentController+"_left");
	inputUp = Input.get_action_strength(currentController+"_up");
	inputDown = Input.get_action_strength(currentController+"_down");
	
	movementDirection.x = inputRight - inputLeft
	movementDirection.y = inputUp - inputDown