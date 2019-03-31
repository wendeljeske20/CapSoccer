extends Node2D

export(String) var playerID
onready var scoreLabel = get_node("../HudManager/ScorePanel/Player"+ playerID +"ScoreLabel")
var score = 0;

var buttonPreload = preload("res://Scenes/Button.tscn")
var buttons = []

var startPositions = []

var currentButton = 0

func _ready():
	pass 

func _process(delta):
	
	scoreLabel.text = str(score)
	
	#for i in range(0, 5):
		#print(buttons[i].position)
	
	#for i in range(0, 5):
		#print(buttons[i].rotation)
	
	#buttons[0].rotation += 1
	#print(buttons[0].rotation)	
	pass

func SpawnButtons():
	for i in range(0, 3):
		var button = buttonPreload.instance()
		button.position = startPositions[i]
		#button.rotation = -PI/2
		get_node("").add_child(button)
		buttons.append(button)
	pass
	
func ResetButtonPositions():
	for i in range(0, 3):
		buttons[i].position = startPositions[i]
	pass

func SetCurrentButton(direction):
	buttons[currentButton].SetDirection(-direction)

# Change between buttons
func CycleCurrentButton(val):
	currentButton += val
	var buttonsQtd = buttons.size()
	if(currentButton >= buttonsQtd):
		currentButton -= buttonsQtd
	elif(currentButton < 0):
		currentButton += buttonsQtd