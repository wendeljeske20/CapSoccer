extends Node2D

# Game Objects
onready var player1 = get_node("Player1")
onready var player2 = get_node("Player2")
onready var ball = get_node("Ball")
onready var matchParams = get_node("MatchParameters")

var currentPlayer = null

# Timers
onready var matchTimer = get_node("HudManager/ScorePanel/MatchTimer")
onready var turnTimer = get_node("HudManager/ScorePanel/TurnTimer")
onready var timeLabel = get_node("HudManager/ScorePanel/TimeLabel")
onready var timeBar = get_node("HudManager/ScorePanel/TurnTimeBar")

# Input Section
var inputRight = 0
var inputLeft = 0
var inputUp = 0
var inputDown = 0
var movementDirection = Vector2()
var changeDirection = false

############
# Functions
############

func _ready():
	# Init players
	#player1.startPositions.append(Vector2(-100, 0))
	#player1.startPositions.append(Vector2(-250, +150))
	#player1.startPositions.append(Vector2(-250, -150))
		
	#player2.startPositions.append(Vector2(100, 0))
	#player2.startPositions.append(Vector2(250, +150))
	#player2.startPositions.append(Vector2(250, -150))
	
	player1.startPositions = matchParams.GetPlayerPosition(true)
	player2.startPositions = matchParams.GetPlayerPosition(false)
	
	player1.SpawnButtons()
	player2.SpawnButtons()
	
	currentPlayer = player1
	
	# Init match params
	matchTimer.wait_time = matchParams.matchTime
	matchTimer.start()
	
	turnTimer.wait_time = matchParams.turnTime
	turnTimer.start()
	
	pass 

func _process(delta):
	
	# Timers
	UpdateTimers()
	CheckTurnTimer()
	
	# Player Input
	ProcessInput()
	if changeDirection:
		currentPlayer.SetCurrentButton(movementDirection.angle())
	
	# Goal scoring
	if ball.goalScored != 0:
		if ball.goalScored == 1:
			player1.score += 1
		else:
			player2.score += 1
		
		ball.goalScored = 0
	pass

func PassTurn():
	currentPlayer.ClearCurrentButtonShoot()
	if currentPlayer == player1:
		currentPlayer = player2
	else:
		currentPlayer = player1
	
	# Reset timer
	turnTimer.start();
	pass

func ProcessInput():
	var currentController = "controller"+currentPlayer.playerID
	
	inputRight = Input.get_action_strength(currentController+"_right")
	inputLeft = Input.get_action_strength(currentController+"_left");
	inputUp = Input.get_action_strength(currentController+"_up");
	inputDown = Input.get_action_strength(currentController+"_down");
	
	# If the absolute value of all the inputs summed is more than 0
	# Just checking if there was any input whatsoever
	if (abs(inputRight + inputLeft + inputUp + inputDown) > 0.5):
		changeDirection = true
	else:
		changeDirection = false
	
	if(Input.is_action_just_pressed(currentController+"_lb")):
		currentPlayer.CycleCurrentButton(-1)
	if(Input.is_action_just_pressed(currentController+"_rb")):
		currentPlayer.CycleCurrentButton(1)
	if(Input.is_action_just_pressed(currentController+"_a_button")):
		currentPlayer.ShootButton()
	if(Input.is_action_just_pressed(currentController+"_start_button")):
		PassTurn()
	
	movementDirection.x = inputRight - inputLeft
	movementDirection.y = inputUp - inputDown

func UpdateTimers():
	timeLabel.set_text(str(int(round(matchTimer.get_time_left()))))
	timeBar.value = turnTimer.get_time_left()

func CheckTurnTimer():
	if turnTimer.time_left <= 0:
		PassTurn()
		turnTimer.start()