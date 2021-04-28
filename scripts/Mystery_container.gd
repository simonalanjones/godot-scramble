## This script manages the creation/removal of Mystery ground targets
## This has the colour swap shader which Mystery objects inherit
## It is also a proxy for propogating the "hit" signal which relays the points

extends Node2D
signal mystery_was_hit
signal points_awarded
signal ground_target_destroyed

const TILE_SIZE = 8
var create_mystery: Reference
var explode_sound: Reference

func _ready() -> void:
	# init colours before next colour swap
	get_material().set_shader_param("right", colours.red)
	get_material().set_shader_param("left", colours.blue_haze)	
	get_material().set_shader_param("middle", colours.pink)
	

func add_mystery(position: Vector2) -> void:
	var mystery = create_mystery.call_func()
	mystery.connect("mystery_hit", self, "_on_mystery_hit")
	mystery.position = position * TILE_SIZE # upscale from tilemap to bitmap
	add_child(mystery)
	
	
# mystery doesn't have an explosion sprite, the points show instead		
func _on_mystery_hit(points: int, mystery: StaticBody2D, projectile: KinematicBody2D) -> void:
	#print('points:' + str(points))
	#print('projectile:' + str(projectile.get_class()))
	#print('target hit:' + str(mystery))
	emit_signal("mystery_was_hit", points, projectile)
	emit_signal("points_awarded", points)
	emit_signal("ground_target_destroyed", mystery.get_class(), projectile.get_class())
	explode_sound.call_func()
	
	
func change_colours(colours) -> void:
	get_material().set_shader_param("middle", colours["fill_colour"])
	get_material().set_shader_param("left", colours["outline_colour"])	
	get_material().set_shader_param("right", colours["third_colour"])
