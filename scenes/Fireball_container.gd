extends Node2D

const MAX_SPAWN = 4
const WAIT_CYCLES = 13

onready var enabled:bool = false
onready var Fireball_scene: PackedScene = preload("res://scenes/Fireball.tscn")
onready var timer:int = 0

# contains a reference to the tilemap camera - injected by World.gd
var camera_property

# function to access tilemap camera
func get_camera_position() -> Vector2:
	return camera_property.call_func()
	

func enable() -> void:
	enabled = true

	
func disable() -> void:
	enabled = false
	for fireball in get_children():
		fireball.queue_free()
		
		
func _process(_delta) -> void:
	if enabled == true:
		timer += 1
		if timer > WAIT_CYCLES and get_child_count() <= MAX_SPAWN:
			timer = 0
			spawn_fireball()
		
		
func spawn_fireball() -> void:
		var fireball = Fireball_scene.instance()
		#calc y position
		randomize()
		var y = randi() % 115
		y += 45
		var x = 224 + get_camera_position().x
		fireball.position = Vector2(x,y)
		add_child(fireball)