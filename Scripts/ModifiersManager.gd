extends Node

onready var ballManager = get_node("../BallManager")

onready var capModifierPreload = preload("res://Scenes/Modifiers/Modifier-Cap.tscn")
onready var buttonModifierPreload = preload("res://Scenes/Modifiers/Modifier-Button.tscn")
onready var officialModifierPreload = preload("res://Scenes/Modifiers/Modifier-Official.tscn")

onready var spawnInterval = 5;
onready var nextSpawnInterval = 0;
onready var hasModifier = false;

onready var modifiers = [
	capModifierPreload,
	buttonModifierPreload,
	officialModifierPreload
]

onready var spawnPositions = [
	Vector2(0, 200),
	Vector2(0, -200),
	Vector2(-400, 200),
	Vector2(-400, -200),
	Vector2(400, 200),
	Vector2(400, -200)
]


func change_ball(ball):
	ballManager.change_ball(ball)
	

func _process(delta):
	if(not hasModifier):
		nextSpawnInterval += delta
		if(nextSpawnInterval >= spawnInterval):
			SpawnModifier()
			nextSpawnInterval = 0
	
func SpawnModifier():
	var random = round(rand_range(-0.4, 2.4))
	var capModifier = modifiers[random].instance()
	
	random = round(rand_range(-0.4, 5.4))
	capModifier.position = spawnPositions[random]
	#print(random)
	ballManager.add_child(capModifier)
	hasModifier = true