extends Node2D


var buttonPreload = preload("res://Scenes/Button.tscn")
var buttons = []

var startPositions = []

# Input Section
var playerNumber = "1"

var inputRight = 0
var inputLeft = 0
var inputUp = 0
var inputDown = 0

var movementDirection = Vector2()

func _ready():
	
	pass 

func _process(delta):
	#for i in range(0, 5):
		#print(buttons[i].position)
	ProcessInput()
	
	#for i in range(0, 5):
		#print(buttons[i].rotation)
	
	#buttons[0].rotation += 1
	#print(buttons[0].rotation)
	
	var dirInRad = deg2rad(movementDirection.angle())
	#buttons[0].SetDirection(dirInRad)
	
	pass

func SpawnButtons():
	for i in range(0, 5):
		var button = buttonPreload.instance()
		button.position = startPositions[i]
		get_node("").add_child(button)
		buttons.append(button)
	pass

func ProcessInput():
	var currentController = "controller"+playerNumber
	inputRight = Input.get_action_strength(currentController+"_right");
	inputLeft = Input.get_action_strength(currentController+"_left");
	inputUp = Input.get_action_strength(currentController+"_up");
	inputDown = Input.get_action_strength(currentController+"_down");
	
	movementDirection.x = inputRight - inputLeft
	movementDirection.y = inputUp - inputDown
	
