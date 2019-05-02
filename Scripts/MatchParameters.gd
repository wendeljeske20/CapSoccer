extends Node

# In seconds
export(int) var turnTime = 10
export(int) var matchTime = 60

# Right side player positions only
# For the left player we invert the X axis
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