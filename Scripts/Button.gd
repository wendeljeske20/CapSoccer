extends RigidBody2D

var speed = 100
var m_angle = 0
var isShooting = false

var shootMin = 0
var shootMax = 15
var shootForce = 0
var shootIncrease = 10


onready var shootBar = get_node("ShootStrength")
onready var sprite
onready var arrowSprite = get_node("ArrowSprite")
onready var outlineSprite = get_node("Sprite/OutlineSprite")

onready var audioHit = get_node("AudioHit")
onready var audioGrass = get_node("AudioGrass")

var spawnPosition = Vector2(0,0)
var shouldReset = false

var isCurrent = false
var colorModulation = 0.0
var colorModUp = false
var colorSet = false

func _ready():
	sprite = get_node("Sprite")

func _process(delta):
	if isShooting:
		
		shootForce += shootIncrease * delta
	
	if(shootForce > shootMax):
		shootForce = shootMax
		shootIncrease *= -1
	
	if(shootForce < shootMin):
		shootForce = shootMin
		shootIncrease *= -1
	
	if isShooting:
		
		shootBar.value = shootForce/shootMax*10.0
	
	if isCurrent && !isShooting:
		arrowSprite.visible = true;
	elif !isCurrent || isShooting:
		arrowSprite.visible = false;
		
	if isCurrent:
		ModulateColor(delta)
		outlineSprite.visible = true
	elif !colorSet:
		outlineSprite.visible = false
		sprite.modulate = Color(1, 1, 1, 1)
		colorSet = true

func SetTexture(texture):
	sprite = get_node("Sprite")
	sprite.set_texture(texture)

func SetHightlightTexture(texture):
	sprite = get_node("Sprite/OutlineSprite")
	sprite.set_texture(texture)

func SetShadowTexture(texture):
	sprite = get_node("ShadowSprite")
	sprite.set_texture(texture)

func _integrate_forces(state):
	rotation = m_angle
	
	if shouldReset:
		# Reseting pos
		# Centering manuall lol
		state.transform.origin = spawnPosition + Vector2(960, 540)
		
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
		# Grass audio
		audioGrass.pitch_scale = lerp(0.75, 1.25, shootForce/shootMax) + rand_range(-0.03, 0.03)
		audioGrass.play()
		
		apply_impulse(Vector2.ZERO, Vector2(cos(rotation), sin(rotation)) * speed * shootForce)
		ClearShoot()

func ClearShoot():
	shootForce = 0
	isShooting = false
	shootBar.visible = false

func Reset():
	shouldReset = true

# Collision audio
func _on_Button_body_entered(body):
	audioHit.play()

func ModulateColor(delta):
	if colorModUp:
		colorModulation += delta * 1.5
	else:
		colorModulation -= delta * 1.5
	
	if colorModulation > 1.0:
		colorModulation = 1.0
		colorModUp = false
	elif colorModulation < 0.1:
		colorModulation = 0.1
		colorModUp = true

	outlineSprite.modulate = Color(1, 1, 1, colorModulation)