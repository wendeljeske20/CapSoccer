extends RigidBody2D

onready var audio = get_node("Audio")

func _on_Crossbar_body_entered(body):
	print("Crossbar collision")
	print(body.name)
	audio.play()