extends Panel

#onready var matchParameters = get_node(
onready var playButton = get_node("Panel/PlayButton")

onready var playerAmountLeftButton = get_node("Panel/PlayersAmountLeftButton")
onready var playerAmountRightButton = get_node("Panel/PlayersAmountRightButton")
onready var playerAmount = get_node("Panel/PlayersAmount")

onready var matchTimeLeftButton = get_node("Panel/MatchTimeLeftButton")
onready var matchTimeRightButton = get_node("Panel/MatchTimeRightButton")
onready var matchTime = get_node("Panel/MatchTime")
const matchTimeStamp = 30

onready var turnTimeLeftButton = get_node("Panel/TurnTimeLeftButton")
onready var turnTimeRightButton = get_node("Panel/TurnTimeRightButton")
onready var turnTime = get_node("Panel/TurnTime")
const turnTimeStamp = 5

func _ready():
	playerAmountLeftButton.connect("pressed",self,"ChangePlayerAmount", [-1])
	playerAmountLeftButton.grab_focus()
	playerAmountRightButton.connect("pressed",self,"ChangePlayerAmount", [1])
	playerAmountRightButton.grab_focus()
	
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
	
	matchTime.text = str(MatchParameters.matchTime/60) + ":" + str(MatchParameters.matchTime%60)
	turnTime.text = str(MatchParameters.turnTime)
	
func Play():
	get_tree().change_scene("Scenes/Match.tscn")
	
func ChangePlayerAmount(value):
	print(value)
	
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