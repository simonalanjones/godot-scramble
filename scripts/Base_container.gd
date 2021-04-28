extends Node2D

signal base_was_hit
signal mission_completed

const TILE_SIZE = 8

var create_base: Reference


func _ready() -> void:
	# init colours before next colour swap
	get_material().set_shader_param("right", colours.red)
	get_material().set_shader_param("left", colours.blue_haze)	
	get_material().set_shader_param("middle", colours.pink)
	
	
func add_base(position: Vector2) -> void:
	var base = create_base.call_func()
	base.connect("base_hit", self, "on_base_hit")
	base.position = position * TILE_SIZE # upscale from tilemap to bitmap
	add_child(base)
		
		
func remove_base() -> void:
	for child in get_children():
		child.queue_free()
		
			
func on_base_hit(points: int) -> void:
	emit_signal("base_was_hit", points)
	yield(get_tree().create_timer(1.5), "timeout")
	emit_signal("mission_completed")
		
		
func change_colours(colours) -> void:
	get_material().set_shader_param("left", colours["third_colour"])
	get_material().set_shader_param("right", colours["outline_colour"])	
	get_material().set_shader_param("middle", colours["fill_colour"])
