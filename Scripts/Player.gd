extends Node2D


var buttonPreload = preload("res://Scenes/Node2D.tscn")
var buttons = []


var startPositions = []

func _ready():
	
	
	
	
		
	
		
		

	pass 
	
func _process(delta):
	#for i in range(0, 5):
		#print(buttons[i].position)
		
	pass
	
func Spawnbuttons():
	for i in range(0, 5):
		var button = buttonPreload.instance()
		button.position = startPositions[i]
		get_node("").add_child(button)
		buttons.append(button)
		
	pass
