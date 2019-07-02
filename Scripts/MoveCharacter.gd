extends Sprite

onready var Tween = get_node("Tween")

export(Vector2) var initPos
export(Vector2) var finalPos

func _ready():
	Tween.interpolate_property(self, "position", initPos, finalPos, 2.5, Tween.TRANS_ELASTIC, Tween.EASE_OUT, rand_range(0.75, 1.15))
	Tween.start()