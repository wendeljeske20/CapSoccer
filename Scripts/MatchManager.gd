extends Node2D

# Game Objects
onready var player1 = get_node("Player1")
onready var player2 = get_node("Player2")
onready var ball = get_node("Ball")
onready var matchParams = get_node("MatchParameters")
onready var matchWinnerPanel = get_node("MatchWinnerPanel")

var currentPlayer = null

# Timers
onready var matchTimer = get_node("MatchTimer")
onready var turnTimer = get_node("TurnTimer")

# UI
onready var timeLabel = get_node("HudManager/ScorePanel/TimeLabel")
onready var timeBar = get_node("HudManager/ScorePanel/TurnTimeBar")
onready var pausePanel = get_node("../Pause")

# Input Section
var inputRight = 0
var inputLeft = 0
var inputUp = 0
var inputDown = 0
var movementDirection = Vector2()
var changeDirection = false

enum MATCH_END {
	NULL = 0,
	LEFT = 1,
	RIGHT = 2,
	TIE = 3
}

############
# Functions
############

func _ready():
	# Init players
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
	if(CheckGoal()):
		var matchWinner = CheckMatchEndGoals()
		if(matchWinner):
			EndMatch(matchWinner)
		else:
			player1.ResetButtonPositions()
			player2.ResetButtonPositions()
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
	#if(Input.is_action_just_pressed(currentController+"_start_button")):
		
	movementDirection.x = inputRight - inputLeft
	movementDirection.y = inputUp - inputDown
	
#pause the process function, physics, timers and the shootBar of current button
func PauseMatch(pause):
	set_process(!pause)
	Physics2DServer.set_active(!pause)
	matchTimer.paused = pause
	turnTimer.paused = pause
	var currentButtonIndex = currentPlayer.currentButton
	currentPlayer.buttons[currentButtonIndex].set_process(!pause)
	
func CheckGoal():
	if ball.goalScored != 0:
		if ball.goalScored == 1:
			player1.score += 1
		else:
			player2.score += 1
		
		ball.goalScored = 0
		return true
	return false

func UpdateTimers():
	timeLabel.set_text(str(int(round(matchTimer.get_time_left()))))
	timeBar.value = turnTimer.get_time_left()

func CheckTurnTimer():
	if turnTimer.time_left <= 0:
		PassTurn()
		turnTimer.start()

func CheckMatchEndGoals():
	if(matchParams.useMaxGoals):
		if(player1.score == matchParams.maxGoals):
			return MATCH_END.LEFT
		if(player2.score == matchParams.maxGoals):
			return MATCH_END.RIGHT
	return MATCH_END.NULL

func CheckMatchEndTime():
	var matchResult = MATCH_END.TIE
	
	if(player1.score > player2.score):
		matchResult = MATCH_END.LEFT
	elif(player1.score < player2.score):
		matchResult = MATCH_END.RIGHT
		
	EndMatch(matchResult)

func EndMatch(result):
	matchWinnerPanel.show()
	# TODO: Change for art instead of Godot label
	matchWinnerPanel.get_child(0).text = "THE WINNER IS " + MATCH_END.keys()[result] + " SIDE!"

# !SIGNAL WITH MATCHTIMER!
func _on_MatchTimer_timeout():
	CheckMatchEndTime()
