extends RigidBody2D

var speed = 100
var m_angle = 0
var isShooting = false

var shootMin = 0
var shootMax = 10
var shootForce = 0
var shootIncrease = 10

var paint = 0;

onready var shootBar = get_node("ShootStrength")
onready var sprite = get_node("Sprite")

func _process(delta):
	if paint == 1:
		sprite.modulate = Color(1, 0, 0)
	if (isShooting):
		shootForce += shootIncrease * delta
	
	if(shootForce > shootMax):
		shootForce = shootMax
		shootIncrease *= -1
	
	if(shootForce < shootMin):
		shootForce = shootMin
		shootIncrease *= -1
	
	if (isShooting):
		shootBar.value = shootForce

func _integrate_forces(state):
	rotation = m_angle

# Angle in radians
func SetDirection(angle):
	m_angle = angle

func Shoot():
	if (!isShooting):
		isShooting = true
		shootBar.visible = true
	else:
		apply_impulse(Vector2.ZERO, Vector2(cos(rotation), sin(rotation)) * speed * shootForce)
		ClearShoot()

func ClearShoot():
	shootForce = 0
	isShooting = false
	shootBar.visible = false
	

	