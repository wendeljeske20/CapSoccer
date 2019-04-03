extends RigidBody2D

var shouldReset = false

func _ready():
	resetPosition()
	pass 

func _integrate_forces(state):
	if shouldReset:
		global_position = Vector2(100,0)
		print("Should reset")
		shouldReset = false

func _process(delta):
	var collidingBodies = get_colliding_bodies()
	checkCollisions(collidingBodies)
	pass

func checkCollisions(collidingBodies):
	for i in collidingBodies.size():
		if collidingBodies[i].name == "GoalLeft":
			checkGoalLeft()
		if collidingBodies[i].name == "GoalRight":
			checkGoalRight()
	pass

func checkGoalLeft():
	print("Player 2 GOAL")
	resetPosition()
	pass

func checkGoalRight():
	print("Player 1 GOAL")
	resetPosition()
	pass

func resetPosition():
	shouldReset = true
	pass