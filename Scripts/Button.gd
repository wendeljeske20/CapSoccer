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

var spawnPosition = Vector2(0,0)
var shouldReset = false

func _ready():
	if paint == 1:
		sprite.modulate = Color(1, 0, 0)

func _process(delta):
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
	
	if shouldReset:
		# Reseting pos
		state.transform.origin = spawnPosition
		
		# Stopping
		state.linear_velocity.x = 0
		state.linear_velocity.y = 0
		state.angular_velocity = 0
		
		# Cleaning variables
		shouldReset = false

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

func Reset():
	shouldReset = true