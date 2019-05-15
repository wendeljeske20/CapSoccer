extends Node

onready var ballManager = get_node("../BallManager")

onready var cap_modifier = load("res://Scenes/Modifiers/Modifier-Cap.tscn").instance()

func change_ball(ball):
	ballManager.change_ball(ball)