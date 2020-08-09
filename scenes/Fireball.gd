extends KinematicBody2D


func _process(_delta):
	position.x -= 3


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
