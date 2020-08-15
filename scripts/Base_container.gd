extends Node2D

signal base_was_hit

onready var Landscape_manager = get_node("/root/World/Landscape_manager")
onready var Base_scene:PackedScene = preload("res://scenes/Base.tscn")


func _ready()->void:
	# init colours before next colour swap
	get_material().set_shader_param("right", colours.red)
	get_material().set_shader_param("left", colours.blue_haze)	
	get_material().set_shader_param("middle", colours.pink)

	
# connected via signal when landscape draw complete
func setup()->void:
	# clear previous base
	remove_base()
		
	# get positions (only 1!) from landscape generator
	var positions = Landscape_manager.get_base_positions()
		
	if positions.size()>0:
		for position in positions:
			var base = Base_scene.instance()
			base.connect("base_was_hit", self, "_on_base_hit")
			base.position = position * 8
			add_child(base)
			
			
func remove_base()->void:
	for child in get_children():
		child.queue_free()
		
		
func _on_base_hit(points)->void:
	emit_signal("base_was_hit",points)
		
		
func change_colours(colours)->void:
	get_material().set_shader_param("left", colours["third_colour"])
	get_material().set_shader_param("right", colours["outline_colour"])	
	get_material().set_shader_param("middle", colours["fill_colour"])
