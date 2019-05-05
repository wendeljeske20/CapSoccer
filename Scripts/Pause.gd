extends Panel

onready var matchManager = get_node("../MatchManager")
onready var resumeButton = get_node("ResumeButton")
onready var quitButton = get_node("QuitButton")

func _ready():
	quitButton.connect("pressed",self,"Quit")
	resumeButton.connect("pressed",self,"Resume")

func Resume():
	hide()
	matchManager.PauseMatch(false)
	
func Pause():
	show()
	matchManager.PauseMatch(true)

func Quit():
	Resume()
	get_tree().change_scene("Scenes/Menu.tscn")
	

func _process(delta):
	if(Input.is_action_just_pressed("controller1_start_button") || 
	Input.is_action_just_pressed("controller2_start_button")):
		if(visible):
			Resume()
		else:
			Pause()
	
