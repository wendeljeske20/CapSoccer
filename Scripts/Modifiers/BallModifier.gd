extends Area2D

var ball = null
export(String) var ballPath = 'res://Scenes/Modifiers'

onready var ballManager = get_node("../BallManager")

func _ready():
	print("Loading cap ball")
	ball = load(ballPath).instance()

func _process(delta):
	var collidingBodies = get_overlapping_bodies()
	checkCollisions(collidingBodies)

func checkCollisions(collidingBodies):
	for i in collidingBodies.size():
		# Checking if it's the ball. Pretty ugly way, but works. *shrug*
		if "goalScored" in collidingBodies[i].get_node(""):
			print("Colided with ball")
			ballManager.change_ball(ball)
			get_parent().remove_child(self)