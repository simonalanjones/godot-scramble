extends Node2D

signal fuel_was_hit

onready var Fuel_scene: PackedScene = preload("res://scenes/Fuel.tscn")

func _ready() -> void:
	# init colours before next colour swap
	get_material().set_shader_param("stand", colours.red)
	get_material().set_shader_param("ul_chars", colours.blue_haze)	
	get_material().set_shader_param("tank", colours.pink)


func add_fuel(position: Vector2) -> void:
	var fuel = Fuel_scene.instance()
	fuel.connect("fuel_hit", self, "_on_fuel_hit")
	fuel.position = position * 8 # upscale from tilemap to bitmap
	add_child(fuel)
	

func remove_fuel() -> void:
	for child in get_children():
		child.queue_free()
				
	
func _on_fuel_hit(points: int) -> void:
	emit_signal('fuel_was_hit',points)
	
	
func change_colours(colours) -> void:
	get_material().set_shader_param("tank", colours["fill_colour"])
	get_material().set_shader_param("ul_chars", colours["outline_colour"])	
	get_material().set_shader_param("stand", colours["third_colour"])
