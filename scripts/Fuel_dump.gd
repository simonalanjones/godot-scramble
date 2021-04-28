extends StaticBody2D

signal fuel_hit

const POINTS = 150

func get_class(): 
	return "Fuel_dump"
	
func explode(projectile: KinematicBody2D) -> void:
	emit_signal('fuel_hit', POINTS, self, projectile)
