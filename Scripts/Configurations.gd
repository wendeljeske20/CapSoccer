extends Panel

onready var backButton = get_node("BackButton")

onready var musicSlide = get_node("MusicSlider")
onready var musicValue = get_node("MusicSlider/MusicValue")

onready var effectsSlide = get_node("EffectsSlider")
onready var effectsValue = get_node("EffectsSlider/EffectsValue")

func _ready():
	backButton.connect("pressed",self,"Back")
	backButton.grab_focus()
	
	musicSlide.connect("value_changed",self,"MusicVolumeChange")
	musicSlide.grab_focus()
	
	effectsSlide.connect("value_changed",self,"EffectsVolumeChange")
	effectsSlide.grab_focus()
	
func Back():
	get_tree().change_scene("Scenes/Menu.tscn")

func MusicVolumeChange(value):
	if value == 0:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"), true)
		musicValue.text = "0%"
	else:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"), false)
		var newDb = lerp(-30, 5, value/100)
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), newDb)
		musicValue.text = str(value) + "%"

func EffectsVolumeChange(value):
	if value == 0:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Effects"), true)
		effectsValue.text = "0%"
	else:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Effects"), false)
		var newDb = lerp(-30, 5, value/100)
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Effects"), newDb)
		effectsValue.text = str(value) + "%"