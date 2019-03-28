extends Sprite

var rb

# Called when the node enters the scene tree for the first time.
func _ready():
	rb = get_parent().get_parent()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotation = deg2rad(rb.angle + 90)
	pass
