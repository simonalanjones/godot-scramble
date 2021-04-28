## A ground target which is created via Containers.gd and Mystery_container.gd
extends StaticBody2D

signal mystery_hit

onready var mystery_points:Array = [100,200,300]
onready var ui_timer: Timer

func get_class() -> String:
	return "Mystery"
	
func explode(projectile) -> void:
	get_node("Sprite").queue_free() 
	get_node("CollisionShape2D").queue_free() # prevent further collisions
	randomize()
	var r = randi() % 3
	var points = mystery_points[r]
	emit_signal('mystery_hit', points, self, projectile)
	
	
	get_node(str(points)).visible = true
	ui_timer = Timer.new()
	add_child(ui_timer)
	ui_timer.set_wait_time(1)
	ui_timer.start()
	yield(ui_timer, "timeout")
	
	get_node(str(points)).visible = false
	queue_free()
