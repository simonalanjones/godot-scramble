extends Node2D

signal mystery_was_hit
onready var Mystery_tilemap = get_node("/root/World/MysteryPositions")
onready var Mystery_scene = preload("res://Mystery.tscn")

func _ready():
	# init colours before next colour swap
	get_material().set_shader_param("right", colours.red)
	get_material().set_shader_param("left", colours.blue_haze)	
	get_material().set_shader_param("middle", colours.pink)
	
	var positions = Mystery_tilemap.get_positions()
	Mystery_tilemap.hide()
	if positions.size()>0:
		for position in positions:
			var mystery = Mystery_scene.instance()
			mystery.connect("mystery_was_hit", self, "_on_mystery_hit")
			mystery.position = position
			add_child(mystery)

func _on_mystery_hit(points):
	emit_signal('mystery_was_hit',points)
	
func change_colour(colours):
	print('we got a new request')
	get_material().set_shader_param("middle", colours.get('fill_colour'))
	get_material().set_shader_param("left", colours.get('outline_colour'))	
	get_material().set_shader_param("right", colours.get('third_colour'))
