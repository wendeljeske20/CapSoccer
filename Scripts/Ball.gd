extends Area2D

func _ready():
	resetPosition()
	pass 

func _process(delta):
	var overlappedAreas = get_overlapping_areas()
	print(overlappedAreas.size())
	checkOverlappedAreas(overlappedAreas)
	pass

func checkOverlappedAreas(overlappedAreas):
	if (overlappedAreas.size() > 0):
		if overlappedAreas[0].name == "GoalLeft":
			checkGoalLeft()
		if overlappedAreas[0].name == "GoalRight":
			checkGoalRight()
	pass

func checkGoalLeft():
	resetPosition()
	pass

func checkGoalRight():
	resetPosition()
	pass

func resetPosition():
	self.set_global_position(Vector2(0,0))
	pass