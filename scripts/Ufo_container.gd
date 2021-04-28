extends Node2D

signal ufo_was_hit 
signal points_awarded

const MAX_SPAWN = 4
const WAIT_CYCLES = 60

var enabled: bool = false
var timer: int = 0
var camera_property: Reference # function to access tilemap camera
var spawn_explosion: Reference
var create_ufo: Reference


func _process(_delta) -> void:
	if enabled == true:
		timer += 1
		if timer > WAIT_CYCLES and get_child_count() <= MAX_SPAWN:
			timer = 0
			spawn_ufo()
			

func remove_ufos() -> void:
	for child in get_children():
		child.queue_free()
			
			
func enable() -> void:
	enabled = true
	
	
func disable() -> void:
	enabled = false
	for ufo in get_children():
		ufo.queue_free()
	
	
func spawn_ufo() -> void:
		var ufo = create_ufo.call_func()
		ufo.connect("ufo_hit", self, "_on_ufo_hit")
		
		randomize()
		var y = 128 + randi() % 15
		var x = 224 + camera_property.call_func().x
		ufo.position = Vector2(x,y)
		add_child(ufo)


func _on_ufo_hit(points: int, ufo: KinematicBody2D):
	emit_signal("ufo_was_hit", points)
	emit_signal("points_awarded", points)
	spawn_explosion.call_func(ufo)
