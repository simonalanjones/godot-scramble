extends AnimatedSprite

		
func _on_Explode_animation_animation_finished():
	queue_free()
	
