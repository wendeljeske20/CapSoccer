extends Control

onready var matchManager = get_node("../MatchManager")
onready var resumeButton = get_node("Pause/ResumeButton")
onready var arenaSelectButton = get_node("Pause/ArenaSelectButton")
onready var quitButton = get_node("Pause/QuitButton")

func _ready():
	quitButton.connect("pressed",self,"Quit")
	arenaSelectButton.connect("pressed",self,"ArenaSelect")
	resumeButton.connect("pressed",self,"Resume")

func Resume():
	UI_Audios.playButtonClick()
	hide()
	matchManager.PauseMatch(false)

func Pause():
	UI_Audios.playButtonClick()
	show()
	resumeButton.grab_focus()
	matchManager.PauseMatch(true)

func ArenaSelect():
	UI_Audios.playButtonClick()
	matchManager.PauseMatch(false) # precisa despausar para não bugar
	get_tree().change_scene("Scenes/ArenaSelect.tscn")

func Quit():
	UI_Audios.playButtonClick()
	Resume()
	get_tree().change_scene("Scenes/Menu.tscn")
	

func _process(delta):
	if(Input.is_action_just_pressed("controller1_start_button") || 
	Input.is_action_just_pressed("controller2_start_button")):
		if(visible):
			Resume()
		else:
			Pause()