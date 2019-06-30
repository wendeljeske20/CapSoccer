extends Panel

#onready var matchParameters = get_node(
onready var playButton = get_node("Panel/PlayButton")

onready var goalAmountLeftButton = get_node("Panel/GoalAmountLeftButton")
onready var goalAmountRightButton = get_node("Panel/GoalAmountRightButton")
onready var goalAmount = get_node("Panel/GoalLimitAmount")

onready var matchTimeLeftButton = get_node("Panel/MatchTimeLeftButton")
onready var matchTimeRightButton = get_node("Panel/MatchTimeRightButton")
onready var matchTime = get_node("Panel/MatchTime")
const matchTimeStamp = 30

onready var turnTimeLeftButton = get_node("Panel/TurnTimeLeftButton")
onready var turnTimeRightButton = get_node("Panel/TurnTimeRightButton")
onready var turnTime = get_node("Panel/TurnTime")
const turnTimeStamp = 1

func _ready():
	goalAmountLeftButton.connect("pressed",self,"ChangeGoalLimitAmount", [-1])
	goalAmountLeftButton.grab_focus()
	goalAmountRightButton.connect("pressed",self,"ChangeGoalLimitAmount", [1])
	goalAmountRightButton.grab_focus()
	
	matchTimeLeftButton.connect("pressed",self,"ChangeMatchTime", [-1])
	matchTimeLeftButton.grab_focus()
	matchTimeRightButton.connect("pressed",self,"ChangeMatchTime", [1])
	matchTimeRightButton.grab_focus()
	
	turnTimeLeftButton.connect("pressed",self,"ChangeTurnTime", [-1])
	turnTimeLeftButton.grab_focus()
	turnTimeRightButton.connect("pressed",self,"ChangeTurnTime", [1])
	turnTimeRightButton.grab_focus()
	
	playButton.connect("pressed",self,"Play")
	playButton.grab_focus()
	
	ChangeGoalLimitAmount(0)
	ChangeMatchTime(0)
	ChangeTurnTime(0)
	
func Play():
	get_tree().change_scene("Scenes/Match.tscn")
	
func ChangeGoalLimitAmount(value):
	var newGoalLimit = MatchParameters.maxGoals + value
	if newGoalLimit <= 0:
		newGoalLimit = 0
		goalAmount.text = "Infinito"
		MatchParameters.useMaxGoals = false
	else:
		goalAmount.text = str(newGoalLimit)
		MatchParameters.useMaxGoals = true
	MatchParameters.maxGoals = newGoalLimit
	
func ChangeMatchTime(value):
	var currentMatchTime = MatchParameters.matchTime
	var newTime = currentMatchTime + matchTimeStamp * value
	if newTime > 0:
		MatchParameters.matchTime = newTime
		if newTime >= 60:
			matchTime.text = str(newTime/60) + ":"
			if newTime%60 < 10:
				matchTime.text += "0"
			matchTime.text += str(newTime%60)
		else:
			matchTime.text = str(newTime)
		MatchParameters.useMaxTime = true
	else:
		MatchParameters.matchTime = 0
		MatchParameters.useMaxTime = false
		matchTime.text = "Infinito"

func ChangeTurnTime(value):
	var currentTime = MatchParameters.turnTime
	var newTime = currentTime + turnTimeStamp * value
	if newTime > 0:
		MatchParameters.turnTime = newTime
		if newTime >= 60:
			turnTime.text = str(newTime/60) + ":"
			if newTime%60 < 10:
				turnTime.text += "0"
			turnTime.text += str(newTime%60)
		else:
			turnTime.text = str(newTime)