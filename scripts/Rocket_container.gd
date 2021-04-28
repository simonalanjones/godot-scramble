extends Node2D

signal rocket_was_hit
signal points_awarded
signal ground_target_destroyed

# references to functions we will need to use
var create_rocket: Reference
var rocket_takeoff_sound: Reference
var spawn_explosion: Reference

# levels 2 & 3 don't launch rockets
var launch_enabled: bool = true

# rockets launch within a specific x range
const MIN_LAUNCH_X = 50
const MAX_LAUNCH_X = 100

const MAX_INFLIGHT_ROCKETS = 2
const TILE_SIZE = 8


func _ready() -> void:
	# init colours before next colour swap
	get_material().set_shader_param("fill", colours.red)
	get_material().set_shader_param("outline", colours.blue_haze)	
	get_material().set_shader_param("thrust", colours.pink)

	
func add_rocket(position: Vector2) -> void:
	var rocket = create_rocket.call_func()
	rocket.connect("rocket_hit", self, "_on_rocket_hit")
	rocket.connect("rocket_exited_screen", self, "_on_rocket_exited_screen")
	rocket.position = position * TILE_SIZE # upscale from tilemap to bitmap
	add_child(rocket)
		
		
func enable_rockets() -> void:
	launch_enabled = true
	
# levels 2 & 3 don't launch rockets
func disable_rockets() -> void:
	launch_enabled = false
	
	
func _process(_delta) -> void:
	if launch_enabled == true:
		launch_next_rocket()
		
		
func launch_next_rocket() -> void:
	var visible_rockets = get_tree().get_nodes_in_group("visible_rockets")
	if get_tree().get_nodes_in_group("inflight_rockets").size() < MAX_INFLIGHT_ROCKETS:
		for rocket in visible_rockets:
			if not rocket.is_in_group("inflight_rockets"):
				var local_pos = rocket.get_global_transform_with_canvas().get_origin()
				if local_pos.x > MIN_LAUNCH_X and local_pos.x < MAX_LAUNCH_X:
					rocket.launch()
					rocket_takeoff_sound.call_func()
					
					
func _on_rocket_hit(points: int, rocket: KinematicBody2D, projectile: KinematicBody2D) -> void:
	spawn_explosion.call_func(rocket)
	emit_signal("rocket_was_hit", points, projectile)
	emit_signal("points_awarded", points)
	emit_signal("ground_target_destroyed", rocket.get_class(), projectile.get_class())
	rocket.queue_free()
	
	
func _on_rocket_exited_screen(rocket: KinematicBody2D) -> void:
	rocket.queue_free()
	
	
func change_colours(colours) -> void:
	get_material().set_shader_param("fill", colours["third_colour"])
	get_material().set_shader_param("outline", colours["outline_colour"])
	get_material().set_shader_param("thrust", colours["fill_colour"])
