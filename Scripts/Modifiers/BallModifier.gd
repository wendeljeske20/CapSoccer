extends Area2D

var ball = null
export(String) var ballPath = 'res://Scenes/Modifiers'

onready var ballManager = get_parent()
onready var modifierManager = get_node("../../ModifiersManager")

func _ready():
	ball = load(ballPath).instance()

func _process(delta):
	var collidingBodies = get_overlapping_bodies()
	checkCollisions(collidingBodies)

func checkCollisions(collidingBodies):
	for i in collidingBodies.size():
		# Checking if it's the ball. Pretty ugly way, but works. *shrug*
		if "goalScored" in collidingBodies[i].get_node(""):
			modifierManager.hasModifier = false
			ballManager.change_ball(ball)
			get_parent().remove_child(self)