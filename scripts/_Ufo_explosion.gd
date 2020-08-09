extends AnimatedSprite

func _ready():
	visible = true
	set_frame(0)
	play('default')
	
	
func _on_Explode_animation_animation_finished():
	queue_free()
