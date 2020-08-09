extends AnimatedSprite

onready var outer_edge_colour
onready var edge_colour
onready var centre_colour

func _ready():
	visible = true
	set_frame(0)
	play('default')
	
	# init colours based on enemy shader colour 
	get_material().set_shader_param("outer_edge", colours.red)
	get_material().set_shader_param("edge", colours.blue_haze)	
	get_material().set_shader_param("centre", colours.pink)
	
	
func _on_Explode_animation_animation_finished():
	queue_free()
	
