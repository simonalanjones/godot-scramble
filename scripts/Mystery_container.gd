## This script manages the creation/removal of Mystery ground targets
## This has the colour swap shader which Mystery objects inherit
## It is also a proxy for propogating the "hit" signal which relays the points

extends Node2D

signal mystery_was_hit
onready var Mystery_scene: PackedScene = preload("res://scenes/Mystery.tscn")

func _ready() -> void:
	# init colours before next colour swap
	get_material().set_shader_param("right", colours.red)
	get_material().set_shader_param("left", colours.blue_haze)	
	get_material().set_shader_param("middle", colours.pink)
	

func add_mystery(position: Vector2) -> void:
	var mystery = Mystery_scene.instance()
	mystery.connect("mystery_hit", self, "_on_mystery_hit")
	mystery.position = position * 8 # upscale from tilemap to bitmap
	add_child(mystery)
	
		
func _on_mystery_hit(points: int) -> void:
	emit_signal("mystery_was_hit",points)
	
	
func change_colours(colours) -> void:
	get_material().set_shader_param("middle", colours["fill_colour"])
	get_material().set_shader_param("left", colours["outline_colour"])	
	get_material().set_shader_param("right", colours["third_colour"])
