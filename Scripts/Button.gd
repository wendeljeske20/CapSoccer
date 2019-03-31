extends Node2D

var speed = 5
var angle = 0
#var shouldMove = false

func _ready():
	pass

func _process(delta):
	pass

#func _physics_process(delta):
	
	#if shouldMove:
	
	#var angleInRad = deg2rad(angle)
	#apply_impulse(Vector2.ZERO, Vector2(cos(angleInRad), sin(angleInRad)) * delta * 1000 * verticalDelta)
	
	#shouldMove = false
	
	#pass

# Angle in radians
func SetDirection(angle):
	rotate(angle)