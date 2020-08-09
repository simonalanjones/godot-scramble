extends AnimatedSprite


func __ready():
	visible = true
	set_frame(0)
		
func _on_Explode_animation_animation_finished():
	queue_free()
