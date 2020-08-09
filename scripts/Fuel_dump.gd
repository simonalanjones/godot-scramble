extends StaticBody2D

signal fuel_was_hit

func get_class(): 
	return "Fuel_dump"
	
func explode():
	emit_signal("fuel_was_hit", 150)
	queue_free()
	
