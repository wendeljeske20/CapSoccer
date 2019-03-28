extends Node2D


var buttonPreload = preload("res://Scenes/Node2D.tscn")
var buttons = []


var startPositions = []

func _ready():
	
	startPositions.append(Vector2(-350, 200))
	startPositions.append(Vector2(-350, -200))
	startPositions.append(Vector2(-250, 100))
	startPositions.append(Vector2(-250, -100))
	startPositions.append(Vector2(-150, 0))
	
	
		
	for i in range(0, 5):
		var button = buttonPreload.instance()
		button.position = startPositions[i]
		get_node("").add_child(button)
		buttons.append(button)
		
		

	pass 
	
func _process(delta):
	#for i in range(0, 5):
		#print(buttons[i].position)
		
	pass
	
func Spawnbutton(position):

	pass
