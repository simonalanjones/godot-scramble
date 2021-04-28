extends Node2D

# This script is a factory for instancing explosions for enemies
# and setting the colours when doing so for ground targets that
# follow the colour changes of the landscape.
# This has a shader attached which some scenes will inherit

var create_explosion: Reference

func _ready():
	# init colours before first colour swap
	get_material().set_shader_param("edges", colours.red)
	get_material().set_shader_param("fill", colours.pink)	
	get_material().set_shader_param("glow", colours.blue_haze)
	
	
# Called as a signal
func change_colours(colours):
	get_material().set_shader_param("edges", colours.get('third_colour'))
	get_material().set_shader_param("fill", colours.get('fill_colour'))
	get_material().set_shader_param("glow", colours.get('outline_colour'))
	
	
# An object is passed to this function and its type can be
# determined by asking its class.
# Depending on the string returned, we choose an animation
func spawn_explosion(object):
	
	var _class:String = object.get_class()
		
	# Mystery object displays a score instead of an explosion
	if not _class == "Mystery":
		
		# set up explosion position using the object's global position
		var explosion_scene = create_explosion.call_func()
		explosion_scene.position.x = object.global_position.x
		explosion_scene.position.y = object.global_position.y
		
		if _class == "Ufo":
			explosion_scene.play("ufo")
			add_child(explosion_scene)
			
		elif _class == "Bomb":
			explosion_scene.play("bomb")
			explosion_scene.centered = true
			add_child(explosion_scene)
			
		else:
			explosion_scene.play("default")
			add_child(explosion_scene)
