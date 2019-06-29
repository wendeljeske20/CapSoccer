extends Node

# Turn timer (in seconds)
export(int) var turnTime = 10

# Game end rules
# Match time
export(int) var matchTime = 180
export(int) var maxGoals = 5

export(bool) var useMaxTime = false
export(bool) var useMaxGoals = false

export(int) var winner = 0

# Right side player positions only
# For the left player we invert the X axis
# TODO: Needs to be dynamic for varying sized teams
# Maybe be a player input?
var playerPositions = [
	Vector2(100, +0),
	Vector2(250, +150),
	Vector2(250, -150)
]

func AddMatchTime(delta):
	matchTime += delta

func GetPlayerPosition(isLeftSide):
	var playerPosCopy = [] + playerPositions
	if(isLeftSide):
		for i in range(playerPosCopy.size()):
			playerPosCopy[i].x *= -1
	return playerPosCopy