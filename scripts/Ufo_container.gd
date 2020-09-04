extends Node2D

const MAX_SPAWN = 4
const WAIT_CYCLES = 60

onready var enabled:bool = false
onready var Ufo_scene: PackedScene = preload("res://scenes/Ufo.tscn")
onready var timer:int = 0

# contains a reference to the tilemap camera - injected by World.gd
var camera_property: Reference

func _process(_delta) -> void:
	if enabled == true:
		timer += 1
		if timer > WAIT_CYCLES and get_child_count() <= MAX_SPAWN:
			timer = 0
			spawn_ufo()
			
# function to access tilemap camera
func get_camera_position() -> Vector2:
	return camera_property.call_func()
	
	
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
		var ufo = Ufo_scene.instance()
		#calc y position
		#randomize()
		#var y = randi() % 15
		var y = 128		
		var x = 224 + get_camera_position().x
		ufo.position = Vector2(x,y)
		add_child(ufo)
