extends RigidBody2D

onready var audio = get_node("Audio")

func _on_Crossbar_body_entered(body):
	print("Crossbar collision with " + body.name)
	audio.pitch_scale = 1.0 + rand_range(-0.05, 0.05)
	audio.play()