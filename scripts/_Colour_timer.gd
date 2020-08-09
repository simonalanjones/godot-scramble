extends Timer

###  NOT NEEDED - CAN BE DELETED ####
# have the timer timeout here and then announce as signal the colour
# changes
const green = Color(0.11,0.76,0)
const purple = Color(0.52,0,0.85)
const red = Color(0.87,0,0)
const light_blue = Color(0,0.76,0.85)
const dark_blue = Color(0,0,0.85)
const yellow = Color(0.87,0.87,0)
const pink = Color(0.88,0,0.85)
const blue_haze = Color(0.76,0.76,0.85)
const silver = Color(0.75,0.75,0.75)
const grey = Color(0.5,0.5,0.5)
const dark_grey = Color(0.25,0.25,0.25)
const black = Color(0,0,0)


onready var RocketShader = preload("res://Rocket.shader")
var colour_counter = 0
signal colour_changed

func _on_Colour_timer_timeout():
	RocketShader.set_shader_param("fill", yellow)
	RocketShader.set_shader_param("outline", purple)
	#change_colour()
	
func change_colour():
	colour_counter+=1
	if colour_counter > 7:
		colour_counter = 1
		# emit signal here
		
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
