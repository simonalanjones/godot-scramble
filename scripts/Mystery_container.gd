extends Node2D

signal mystery_was_hit

onready var Mystery_scene = preload("res://scenes/Mystery.tscn")
onready var Landscape_manager = get_node("/root/World/Landscape_manager")

func _ready():
	# init colours before next colour swap
	get_material().set_shader_param("right", colours.red)
	get_material().set_shader_param("left", colours.blue_haze)	
	get_material().set_shader_param("middle", colours.pink)
	
	
func setup():
	for child in get_children():
		child.queue_free()
	var positions = Landscape_manager.get_mystery_positions()
	if positions.size()>0:
		for position in positions:
			var mystery = Mystery_scene.instance()
			mystery.connect("mystery_was_hit", self, "_on_mystery_hit")
			mystery.position = position * 8
			add_child(mystery)
			
			
func _on_mystery_hit(points):
	emit_signal("mystery_was_hit",points)
	
	
func change_colours(colours):
	get_material().set_shader_param("middle", colours["fill_colour"])
	get_material().set_shader_param("left", colours["outline_colour"])	
	get_material().set_shader_param("right", colours["third_colour"])
