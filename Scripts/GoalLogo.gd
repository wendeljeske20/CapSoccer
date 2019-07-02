extends Sprite

onready var Tween = get_node("Tween")
onready var Timer = get_node("Timer")

export(Vector2) var scaleMin
export(Vector2) var scaleMax

func _ready():
	#StartEffect()
	pass

func StartEffect():
	scale = scaleMin
	show()
	
	Tween.interpolate_property(self, "scale", scaleMin, scaleMax, 2.0, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	Tween.start()
	
	Timer.start()

func _on_Timer_timeout():
	hide()
