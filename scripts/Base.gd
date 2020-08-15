extends StaticBody2D

signal base_was_hit

func get_class(): 
	return "Base"
	
func explode():
	emit_signal("base_was_hit", 800)
	queue_free()
