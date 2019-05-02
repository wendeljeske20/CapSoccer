extends Node2D

export(String) var playerID
onready var scoreLabel = get_node("../HudManager/ScorePanel/Player"+ playerID +"ScoreLabel")
var score = 0;

var buttonPreload = preload("res://Scenes/Button.tscn")
var buttons = []
var currentButton = 0

var startPositions = []

func _ready():
	pass 

func _process(delta):
	scoreLabel.text = str(score)
	pass

func SpawnButtons():
	for i in range(0, startPositions.size()):
		var button = buttonPreload.instance()
		if playerID == "1":
			button.paint = 1
			
		# Used to reset
		button.spawnPosition = startPositions[i]
		# Setting position manually to avoid visual bug
		button.position = startPositions[i]
		
		get_node("").add_child(button)
		buttons.append(button)
	pass

func ResetButtonPositions():
	for i in range(0, buttons.size()):
		buttons[i].Reset()
	pass

func SetCurrentButton(direction):
	buttons[currentButton].SetDirection(-direction)

# Change between buttons
func CycleCurrentButton(val):
	ClearCurrentButtonShoot()
	currentButton += val
	var buttonsQtd = buttons.size()
	if(currentButton >= buttonsQtd):
		currentButton -= buttonsQtd
	elif(currentButton < 0):
		currentButton += buttonsQtd

func ShootButton():
	buttons[currentButton].Shoot()

func ClearCurrentButtonShoot():
	buttons[currentButton].ClearShoot()