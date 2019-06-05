extends Panel

onready var startButton = get_node("StartButton")
onready var configurationsButton = get_node("ConfigurationsButton")
#onready var creditsButton = get_node("CreditsButton")

onready var quitButton = get_node("QuitButton")

func _ready():
	startButton.connect("pressed",self,"Play")
	startButton.grab_focus()
	configurationsButton.connect("pressed",self,"Configurations")
	configurationsButton.grab_focus()
	#creditsButton.connect("pressed",self,"Credits")
	#creditsButton.grab_focus()
	quitButton.connect("pressed",self,"Quit")
	quitButton.grab_focus()
	#Não entendi o que tava acontecendo antes então só dei o focus aqui
	startButton.grab_focus()
	
func Play():
	get_tree().change_scene("Scenes/ArenaSelect.tscn")

func Configurations():
	get_tree().change_scene("Scenes/Configurations.tscn")
	
func Credits():
	get_tree().change_scene("Scenes/Credits.tscn")
	
func Quit():
	get_tree().quit()
