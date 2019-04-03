extends RigidBody2D

var shouldReset = false
var canScore = true

# 1 for player 1 and 2 for player 2. 0 for none
var goalScored = 0

func _ready():
	resetPosition()
	pass 

func _integrate_forces(state):
	if shouldReset:
		# Reseting pos
		state.transform.origin.x = 0
		state.transform.origin.y = 0
		
		# Stopping
		state.linear_velocity.x = 0
		state.linear_velocity.y = 0
		state.angular_velocity = 0
		
		# Cleaning variables
		shouldReset = false
		canScore = true
		
		# Avoiding double collision bug
		contact_monitor = false
	else:
		contact_monitor = true
		var collidingBodies = get_colliding_bodies()
		checkCollisions(collidingBodies)
	pass

func checkCollisions(collidingBodies):
	for i in collidingBodies.size():
		if collidingBodies[i].name == "GoalLeft":
			checkGoal(true)
		if collidingBodies[i].name == "GoalRight":
			checkGoal(false)
	pass

func checkGoal(isLeftSide):
	if(canScore):
		if isLeftSide:
			goalScored = 2
		else:
			goalScored = 1
		canScore = false
		resetPosition()
	pass

func resetPosition():
	shouldReset = true
	pass