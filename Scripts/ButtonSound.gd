extends Button

func _ready():
	get_node("").connect("pressed",get_node("/root/UI_Audios"),"playButtonClick")
	get_node("").connect("focus_entered",get_node("/root/UI_Audios"),"playButtonFocus")