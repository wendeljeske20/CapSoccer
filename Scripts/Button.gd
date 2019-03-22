extends RigidBody2D

var speed = 5
var shouldMove = false
var angle = 0

func _process(delta):
	
	if Input.is_action_pressed("ui_right"):
		angle += 4
	
	if Input.is_action_pressed("ui_left"):
		angle -= 4
	
	if Input.is_action_pressed("ui_select"):
		shouldMove = true
	
	pass

func _physics_process(delta):
	
	if shouldMove:
		var angleInRad = deg2rad(angle)
		apply_impulse(Vector2.ZERO, Vector2(cos(angleInRad), sin(angleInRad)) * delta * 1000)
		shouldMove = false
	
	pass
