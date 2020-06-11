extends Node2D

signal rocket_was_hit
onready var Rocket_tilemap = get_node("/root/World/RocketPositions")
onready var Rocket_scene = preload("res://Rocket.tscn")

func _ready():
	# init colours before next colour swap
	get_material().set_shader_param("fill", colours.red)
	get_material().set_shader_param("outline", colours.blue_haze)	
	get_material().set_shader_param("thrust", colours.pink)
	
	var positions = Rocket_tilemap.get_positions()
	Rocket_tilemap.hide()
	if positions.size()>0:
		for position in positions:
			var rocket = Rocket_scene.instance()
			rocket.connect("rocket_hit", self, "_on_rocket_hit")
			rocket.position = position
			add_child(rocket)
			
func _on_rocket_hit(points):
	emit_signal('rocket_was_hit',points)
		
func change_colour(colours):
	get_material().set_shader_param("fill", colours.get('third_colour'))
	get_material().set_shader_param("outline", colours.get('outline_colour'))	
	get_material().set_shader_param("thrust", colours.get('fill_colour'))
		