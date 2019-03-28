extends Node2D

var speed = 5
var angle = 0
#var shouldMove = false

func _process(delta):
	#self.rotation = self.rotation + 0.1
	#self.rotation_degrees += 1
	pass

#func _physics_process(delta):
	
	#if shouldMove:
	
	#var angleInRad = deg2rad(angle)
	#apply_impulse(Vector2.ZERO, Vector2(cos(angleInRad), sin(angleInRad)) * delta * 1000 * verticalDelta)
	
	#shouldMove = false
	
	#pass

# Direction is the angle in radians
func SetDirection(direction):
	self.rotation = deg2rad(90)