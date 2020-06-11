extends StaticBody2D

signal fuel_was_hit

func explode():
	emit_signal('fuel_was_hit',150)
	queue_free()	