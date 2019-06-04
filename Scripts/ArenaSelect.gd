extends Panel

#onready var matchParameters = get_node(
onready var playButton = get_node("Panel/PlayButton")
onready var playerAmountLeftButton = get_node("Panel/PlayerAmountLeftButton")
onready var playerAmountRightButton = get_node("Panel/PlayerAmountRightButton")
onready var matchTimeLeftButton = get_node("Panel/MatchTimeLeftButton")
onready var matchTimeRightButton = get_node("Panel/MatchTimeRightButton")
onready var turnTimeLeftButton = get_node("Panel/TurnTimeLeftButton")
onready var turnTimeRightButton = get_node("Panel/TurnTimeRightButton")


func _ready():
	playButton.connect("pressed",self,"Play")
	playButton.grab_focus()
	
func Play():
	get_tree().change_scene("Scenes/Match.tscn")
	
