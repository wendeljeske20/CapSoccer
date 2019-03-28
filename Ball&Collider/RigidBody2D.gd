extends Area2D

var ball_friction : float
var bounciness : float
var size : Vector2
var screenSize

func _ready():
	screenSize = get_viewport_rect().size
	resetPosition()
	pass 

func _process(delta):
	var overlappedAreas = get_overlapping_areas()
	print(overlappedAreas.size())
	pass

func checkOverlappedAreas(overlappedAreas):
	
	if (overlappedAreas.size() > 0):
		if overlappedAreas.has():
			checkField()
		if overlappedAreas.has():
			checkGoalLeft()
		if overlappedAreas.has():
			checkGoalRight()
	
	pass

func checkField():
	pass

func checkGoalLeft():
	
	resetPosition()
	pass

func checkGoalRight():
	
	resetPosition()
	pass

func resetPosition():
	#self.set_global_position(Vector2(-(screenSize.x / 2), screenSize.y / 2))
	self.set_global_position(Vector2(0,0))
	pass