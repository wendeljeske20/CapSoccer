extends Sprite

onready var Tween = get_node("Tween")
onready var Timer = get_node("Timer")

export(Vector2) var scaleMin
export(Vector2) var scaleMax

export(Vector2) var posInit
export(Vector2) var posFinal

func _ready():
	Tween.interpolate_property(self, "position", posInit, posFinal, 2.5, Tween.TRANS_ELASTIC, Tween.EASE_OUT, 0.3)
	Tween.interpolate_property(self, "scale", scaleMax, scaleMin, 2.5, Tween.TRANS_ELASTIC, Tween.EASE_OUT, 0.6)
	Tween.start()

func _on_Timer_timeout():
	print("Timeout")
	Tween.interpolate_property(self, "scale", scaleMin, scaleMin*1.25, 0.7, Tween.TRANS_CIRC, Tween.EASE_IN)
	Tween.interpolate_property(self, "scale", scaleMin*1.25, scaleMin, 1.5, Tween.TRANS_ELASTIC, Tween.EASE_OUT, 0.7)
	Tween.start()
