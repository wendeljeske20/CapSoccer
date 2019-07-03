extends Node2D

# Game Objects
onready var player1 = get_node("Player1")
onready var player2 = get_node("Player2")
onready var matchWinnerPanel = get_node("MatchWinnerPanel")

var currentPlayer = null

# Timers
onready var matchTimer = get_node("MatchTimer")
onready var turnTimer : Timer = get_node("TurnTimer")
onready var goalPause = get_node("GoalPause")
onready var matchStartTimer = get_node("StartGameLabel/Timer")

# UI
onready var timeLabel = get_node("HudManager/ScorePanel/TimeLabel")
onready var timeBar = get_node("HudManager/TurnTimeBar")
onready var pausePanel = get_node("../Pause")
onready var logo = get_node("Logo")
onready var startLabel = get_node("StartGameLabel")

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

var scoringPlayer = null

func _ready():
	# Init players
	player1.startPositions = MatchParameters.GetPlayerPosition(true)
	player2.startPositions = MatchParameters.GetPlayerPosition(false)
	
	player1.SpawnButtons()
	player2.SpawnButtons()
	
	currentPlayer = player1
	currentPlayer.SetButtonHightlight()
	
	# Init match params
	matchTimer.wait_time = MatchParameters.matchTime
	matchTimer.start()
	
	turnTimer.wait_time = MatchParameters.turnTime
	turnTimer.start()
	timeBar.max_value = MatchParameters.turnTime
	timeBar.value = MatchParameters.turnTime
	
	# Starting ball
	#get_node("BallManager").change_ball(load("res://Scenes/Balls/Ball-Official.tscn").instance())
	
	matchStartTimer.start()

func _process(delta):
	
	# Timers
	if matchStartTimer.get_time_left() > 0:
		PauseTimers(true)
		startLabel.show()
		startLabel.text = str(int(ceil(matchStartTimer.get_time_left())))
	else:
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
			PauseTimers(true)
			UI_Audios.playGoal()
			logo.StartEffect()
			goalPause.start()
			
			player1.ResetButtonPositions()
			player2.ResetButtonPositions()
			
			InvertTurn()
			
	pass

func PauseTimers(pause):
	matchTimer.paused = pause
	turnTimer.paused = pause

func InvertTurn():
	currentPlayer.ClearCurrentButton()
	if scoringPlayer == player1:
		currentPlayer = player2
	else:
		currentPlayer = player1
	
	currentPlayer.SetButtonHightlight()
	# Reset timer
	turnTimer.start();
	pass

func PassTurn():
	currentPlayer.ClearCurrentButton()
	if currentPlayer == player1:
		currentPlayer = player2
	else:
		currentPlayer = player1
	
	currentPlayer.SetButtonHightlight()
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
	
	movementDirection.x = inputRight - inputLeft
	movementDirection.y = inputUp - inputDown
	
	if !turnTimer.paused:
		if(Input.is_action_just_pressed(currentController+"_lb")):
			currentPlayer.CycleCurrentButton(-1)
		if(Input.is_action_just_pressed(currentController+"_rb")):
			currentPlayer.CycleCurrentButton(1)
		if(Input.is_action_just_pressed(currentController+"_a_button")):
			currentPlayer.ShootButton()

# Pause the process function, physics, timers and the shootBar of current button
func PauseMatch(pause):
	set_process(!pause)
	Physics2DServer.set_active(!pause)
	PauseTimers(pause)
	var currentButtonIndex = currentPlayer.currentButton
	currentPlayer.buttons[currentButtonIndex].set_process(!pause)
	
func CheckGoal():
	var ball = get_node("Ball")
	if ball.goalScored != 0:
		if ball.goalScored == 1:
			player1.score += 1
			scoringPlayer = player1
		else:
			player2.score += 1
			scoringPlayer = player2
		
		ball.goalScored = 0
		return true
	return false

func UpdateTimers():
	
	timeBar.value = turnTimer.get_time_left()
	
	if MatchParameters.matchTime > 0:
		var newTime = int(round(matchTimer.get_time_left()))
		var newText = ""
		if newTime >= 60:
				newText = str(newTime/60) + ":"
				if newTime%60 < 10:
					newText += "0"
				newText += str(newTime%60)
		else:
			newText = str(newTime)
		
		timeLabel.set_text(newText)
	else:
		timeLabel.set_text("-")

func CheckTurnTimer():
	if turnTimer.time_left <= 0:
		PassTurn()
		turnTimer.start()

func CheckMatchEndGoals():
	if(MatchParameters.useMaxGoals):
		if(player1.score == MatchParameters.maxGoals):
			return MATCH_END.LEFT
		if(player2.score == MatchParameters.maxGoals):
			return MATCH_END.RIGHT
			
	MatchParameters.player1Score = player1.score
	MatchParameters.player2Score = player2.score
	return MATCH_END.NULL

func CheckMatchEndTime():
	var matchResult = MATCH_END.TIE
	
	if(player1.score > player2.score):
		matchResult = MATCH_END.LEFT
	elif(player1.score < player2.score):
		matchResult = MATCH_END.RIGHT
		
	MatchParameters.player1Score = player1.score
	MatchParameters.player2Score = player2.score
	
	EndMatch(matchResult)

func EndMatch(result):
	UI_Audios.playWhistle()
	MatchParameters.winner = result
	##CHAMA AQUI
	get_tree().change_scene("Scenes/MatchEnd.tscn")

# !SIGNAL WITH MATCHTIMER!
func _on_MatchTimer_timeout():
	if MatchParameters.useMaxTime:
		CheckMatchEndTime()

func _on_GoalPause_timeout():
	PauseTimers(false)
	matchStartTimer.start()

func _on_Timer_timeout():
	startLabel.hide()
	PauseTimers(false)
	UI_Audios.playWhistle()
