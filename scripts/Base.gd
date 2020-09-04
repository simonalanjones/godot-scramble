## The one (and only!) base is positioned at the end of stage 6
## Destroying the base will present you with the congratulations screen
## plus 800 points and put you back at stage 1 to run through again

extends StaticBody2D

signal base_hit

func get_class() -> String: 
	return "Base"
	
func explode() -> void:
	emit_signal("base_hit", 800)
	queue_free()
