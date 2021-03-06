extends RigidBody2D

var shouldReset = false
var canScore = true

# 1 for player 1 and 2 for player 2. 0 for none
var goalScored = 0

var spawnPos = null
var spawnVel = null

onready var audio = get_node("Audio")

func _ready():
	resetPosition()
	pass 

func _integrate_forces(state):
	if shouldReset:
		# Set to spawn pos if just created
		if spawnPos != null:
			state.transform.origin = spawnPos
			state.linear_velocity = spawnVel
			shouldReset = false
			spawnPos = null
			return
			
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
	if(collidingBodies.size()>0):
		audio.pitch_scale = rand_range(0.95, 1.05)
		audio.play()
		for i in collidingBodies.size():
			# Checking if it's a goal. Pretty ugly way, but works. *shrug*
			if "isLeftSide" in collidingBodies[i].get_node(""):
				checkGoal(collidingBodies[i].get_node("").isLeftSide)

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

func spawn(pos, lin_vel):
	shouldReset = true
	spawnPos = pos
	spawnVel = lin_vel