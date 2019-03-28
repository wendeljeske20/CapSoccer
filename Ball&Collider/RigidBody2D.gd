extends Area2D

var ball_friction : float
var bounciness : float
var size : Vector2

func _ready():
	pass 

func _process(delta):
	var overlappedAreas = get_overlapping_areas()
	print(overlappedAreas.size())
	pass

func checkOverlappedAreas(overlappedAreas):
	
	if (overlappedAreas.size() > 0):
		for area in overlappedAreas:
			
	
	pass

func checkField():
	pass

func checkGoalLeft():
	pass

func checkGoalRight():
	pass

func resetPosition():
	pass