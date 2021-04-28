extends Node2D

signal fuel_was_hit
signal points_awarded
signal fuel_restored
signal ground_target_destroyed

const TILE_SIZE = 8

# functions we will need to use
var spawn_explosion: Reference
var create_fuel: Reference
var explode_sound: Reference


func _ready() -> void:
	# init colours before first colour swap
	get_material().set_shader_param("stand", colours.red)
	get_material().set_shader_param("ul_chars", colours.blue_haze)	
	get_material().set_shader_param("tank", colours.pink)


func add_fuel(position: Vector2) -> void:
	var fuel = create_fuel.call_func()
	fuel.connect("fuel_hit", self, "_on_fuel_hit")
	fuel.position = position * TILE_SIZE # upscale from tilemap to bitmap
	add_child(fuel)
	
	
func _on_fuel_hit(points: int, fuel: StaticBody2D, projectile: KinematicBody2D) -> void:
	emit_signal("points_awarded", points)
	emit_signal("fuel_restored")
	emit_signal("fuel_was_hit", points, projectile)
	emit_signal("ground_target_destroyed", fuel.get_class(), projectile.get_class())
	spawn_explosion.call_func(fuel)
	explode_sound.call_func()
	fuel.queue_free()
	
	
func change_colours(colours) -> void:
	get_material().set_shader_param("tank", colours["fill_colour"])
	get_material().set_shader_param("ul_chars", colours["outline_colour"])	
	get_material().set_shader_param("stand", colours["third_colour"])
