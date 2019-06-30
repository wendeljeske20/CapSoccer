extends Node

export(AudioStream) var buttonClick
export(AudioStream) var buttonFocus

export(Array, AudioStream) var goalSounds

onready var buttonClickNode = null
onready var buttonFocusNode = null
onready var goalAudioNode = null

func playButtonClick():
	if buttonClickNode == null:
		buttonClickNode = get_node("ButtonClick")
		buttonClickNode.stream = buttonClick
	buttonClickNode.pitch_scale = 1.0 + rand_range(-0.2, 0.2)
	buttonClickNode.play()

func playButtonFocus():
	if buttonFocusNode == null:
		buttonFocusNode = get_node("ButtonFocus")
		buttonFocusNode.stream = buttonFocus
	buttonFocusNode.pitch_scale = 1.0 + rand_range(-0.25, 0.25)
	buttonFocusNode.play()

func playGoal():
	if goalAudioNode == null:
		goalAudioNode = get_node("GoalAudio")
	goalAudioNode.stream = goalSounds[randi() % goalSounds.size()]
	goalAudioNode.play()