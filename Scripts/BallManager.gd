extends Node

onready var ball_cap = load("res://Scenes/Balls/Ball-Cap.tscn").instance()
onready var ball_button = load("res://Scenes/Balls/Ball-Button.tscn").instance()
onready var ball_official = load("res://Scenes/Balls/Ball-Official.tscn").instance()

func change_ball(ball):
	print("BALL MODIFIER!")
	var parent = get_parent()
	var old_ball = parent.get_node("Ball")
	var pos = old_ball.position
	var lin_vel = old_ball.linear_velocity
	# Maybe we want angular velocity too
	
	parent.remove_child(old_ball)
	
	ball.position = pos
	ball.linear_velocity = lin_vel
	parent.add_child(ball)
	var new_ball = parent.get_node("Ball")
	# Godot physics lol
	new_ball.spawn(pos, lin_vel)