## A ground target which is created via Containers.gd and Mystery_container.gd

extends StaticBody2D

var mystery_points:Array = [100,200,300]
signal mystery_hit

func get_class() -> String:
	return "Mystery"
	
func explode() -> void:
	get_node("Sprite").queue_free() 
	get_node("CollisionShape2D").queue_free() # prevent further collisions
	randomize()
	var r = randi() % 3
	var points = mystery_points[r]
	emit_signal('mystery_hit',points)
	get_node(str(points)).visible = true
	yield(get_tree().create_timer(1),"timeout")
	get_node(str(points)).visible = false
	queue_free()
