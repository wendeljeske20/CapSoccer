extends Node2D

export(bool) var isLeftSide

func _ready():
	get_node("GoalCollider").isLeftSide = isLeftSide
