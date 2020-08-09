extends Node2D

signal rocket_was_hit

onready var Landscape_manager = get_node("/root/World/Landscape_manager")
onready var Rocket_scene:PackedScene = preload("res://scenes/Rocket_k2d.tscn")
onready var timer_var:int = 0
onready var launch_enabled:bool = true

# contains reference to camera
#var camera_property
# function to access tilemap camera
#func get_camera_position() -> Vector2:
#	return camera_property.call_func()
	
	
func _ready()->void:
	# init colours before next colour swap
	get_material().set_shader_param("fill", colours.red)
	get_material().set_shader_param("outline", colours.blue_haze)	
	get_material().set_shader_param("thrust", colours.pink)

	
# connected via signal when landscape draw complete
func setup()->void:
	# clear any previous rockets
	for child in get_children():
		child.queue_free()
		
	# get rocket positions from landscape generator
	var positions = Landscape_manager.get_rocket_positions()
	
	if positions.size()>0:
		for position in positions:
			var rocket = Rocket_scene.instance()
			rocket.connect("rocket_hit", self, "_on_rocket_hit")
			rocket.position = position * 8
			add_child(rocket)
			
			
func enable_rockets()->void:
	launch_enabled = true
	
	
func disable_rockets()->void:
	launch_enabled = false
	
	
func _process(_delta)->void:
	#print('camera:' + str(get_camera_position().x))
	if launch_enabled == true:
		launch_next_rocket()
		
		
func launch_next_rocket()->void:
	var visible_rockets = get_tree().get_nodes_in_group("visible_rockets")
	
	if get_tree().get_nodes_in_group("inflight_rockets").size() < 2:
		for rocket in visible_rockets:
			if not rocket.is_in_group("inflight_rockets"):
				var local_pos = rocket.get_global_transform_with_canvas().get_origin()
				if local_pos.x > 50 and local_pos.x < 100:
					rocket.launch()
					
						
func _on_rocket_hit(points)->void:
	emit_signal("rocket_was_hit",points)
		
		
func change_colours(colours)->void:
	get_material().set_shader_param("fill", colours["third_colour"])
	get_material().set_shader_param("outline", colours["outline_colour"])	
	get_material().set_shader_param("thrust", colours["fill_colour"])
