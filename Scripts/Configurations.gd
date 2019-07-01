extends Panel

onready var backButton = get_node("BackButton")

onready var musicSlide = get_node("MusicSlider")
onready var musicValue = get_node("MusicSlider/MusicValue")

onready var effectsSlide = get_node("EffectsSlider")
onready var effectsValue = get_node("EffectsSlider/EffectsValue")

onready var shaderButton = get_node("ScreenEffectButton")
onready var shaderLabel = get_node("ScreenEffectButton/Label")

onready var fullscreenButton = get_node("FullscreenButton")
onready var fullscreenLabel = get_node("FullscreenButton/Label")

func _ready():
	backButton.connect("pressed",self,"Back")
	backButton.grab_focus()
	
	musicSlide.connect("value_changed",self,"MusicVolumeChange")
	musicSlide.connect("focus_entered",get_node("/root/UI_Audios"),"playButtonFocus")
	musicSlide.grab_focus()
	musicSlide.value = MatchParameters.musicVolume
	MusicVolumeChange(MatchParameters.musicVolume)
	
	effectsSlide.connect("value_changed",self,"EffectsVolumeChange")
	effectsSlide.connect("focus_entered",get_node("/root/UI_Audios"),"playButtonFocus")
	effectsSlide.grab_focus()
	effectsSlide.value = MatchParameters.effectsVolume
	EffectsVolumeChange(MatchParameters.effectsVolume)
	
	shaderButton.connect("pressed",self,"ToggleShaderEffect")
	shaderButton.grab_focus()
	
	fullscreenButton.connect("pressed",self,"ToggleFullScreen")
	
	SetShaderLabel()
	SetFullscreenLabel()
	
	backButton.grab_focus()

func SetFullscreenLabel():
	if OS.window_fullscreen:
		fullscreenLabel.text = "LIGADO"
	else:
		fullscreenLabel.text = "DESLIGADO"

func ToggleFullScreen():
	OS.window_fullscreen = !OS.window_fullscreen
	SetFullscreenLabel()

func SetShaderLabel():
	if ShaderController.shaderOn:
		shaderLabel.text = "LIGADO"
	else:
		shaderLabel.text = "DESLIGADO"

func ToggleShaderEffect():
	ShaderController.shaderOn = !ShaderController.shaderOn
	get_node("OverlayShader").Reset()
	SetShaderLabel()

func Back():
	get_tree().change_scene("Scenes/Menu.tscn")

func MusicVolumeChange(value):
	if value != MatchParameters.musicVolume:
		UI_Audios.playButtonClick()
	MatchParameters.musicVolume = value
	if value == 0:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"), true)
		musicValue.text = "0%"
	else:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"), false)
		var newDb = lerp(-40, 15, value/100)
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), newDb)
		musicValue.text = str(value) + "%"

func EffectsVolumeChange(value):
	if value != MatchParameters.effectsVolume:
		UI_Audios.playButtonClick()
	
	MatchParameters.effectsVolume = value
	if value == 0:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Effects"), true)
		effectsValue.text = "0%"
	else:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Effects"), false)
		var newDb = lerp(-40, 15, value/100)
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Effects"), newDb)
		effectsValue.text = str(value) + "%"