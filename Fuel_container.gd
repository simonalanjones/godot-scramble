extends Node2D

signal fuel_was_hit
onready var Fuel_tilemap = get_node("/root/World/FuelPosition2")
onready var Fuel_scene = preload("res://Fuel.tscn")

func _ready():
	# init colours before next colour swap
	get_material().set_shader_param("stand", colours.red)
	get_material().set_shader_param("ul_chars", colours.blue_haze)	
	get_material().set_shader_param("tank", colours.pink)
	
	var positions = Fuel_tilemap.get_positions()
	Fuel_tilemap.hide()
	if positions.size()>0:
		for position in positions:
			var fuel = Fuel_scene.instance()
			fuel.connect("fuel_was_hit", self, "_on_fuel_hit")
			fuel.position = position
			add_child(fuel)

func _on_fuel_hit(points):
	emit_signal('fuel_was_hit',points)

func change_colour(colours):
	get_material().set_shader_param("tank", colours.get('fill_colour'))
	get_material().set_shader_param("ul_chars", colours.get('outline_colour'))	
	get_material().set_shader_param("stand", colours.get('third_colour'))
				