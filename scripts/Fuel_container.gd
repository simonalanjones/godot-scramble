extends Node2D

signal fuel_was_hit

onready var Fuel_scene = preload("res://scenes/Fuel.tscn")
onready var Landscape_manager = get_node("/root/World/Landscape_manager")


func _ready():
	# init colours before next colour swap
	get_material().set_shader_param("stand", colours.red)
	get_material().set_shader_param("ul_chars", colours.blue_haze)	
	get_material().set_shader_param("tank", colours.pink)


func remove_fuel()->void:
	for child in get_children():
		child.queue_free()
				
	
func setup():
	for child in get_children():
		child.queue_free()
		
	var positions = Landscape_manager.get_fuel_positions()

	if positions.size()>0:
		for position in positions:
			var fuel = Fuel_scene.instance()
			fuel.connect("fuel_was_hit", self, "_on_fuel_hit")
			fuel.position = position * 8
			add_child(fuel)
			
			
func _on_fuel_hit(points):
	emit_signal('fuel_was_hit',points)
	
	
func change_colours(colours):
	get_material().set_shader_param("tank", colours["fill_colour"])
	get_material().set_shader_param("ul_chars", colours["outline_colour"])	
	get_material().set_shader_param("stand", colours["third_colour"])
