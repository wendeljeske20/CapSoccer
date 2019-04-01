extends RigidBody2D

var speed = 1000
var m_angle = 0

func _integrate_forces(state):
	rotation = m_angle

# Angle in radians
func SetDirection(angle):
	m_angle = angle

func Shoot():
	apply_impulse(Vector2.ZERO, Vector2(cos(rotation), sin(rotation)) * speed)