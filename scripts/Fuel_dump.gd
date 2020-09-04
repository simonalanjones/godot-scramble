extends StaticBody2D

signal fuel_hit

func get_class(): 
	return "Fuel_dump"
	
func explode() -> void:
	emit_signal("fuel_hit", 150)
	queue_free()
