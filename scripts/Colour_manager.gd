extends Node

signal colours_did_change

const GREEN = Color(0.11,0.76,0)
const PURPLE = Color(0.52,0,0.85)
const RED = Color(0.87,0,0)
const LIGHT_BLUE = Color(0,0.76,0.85)
const DARK_BLUE = Color(0,0,0.85)
const YELLOW = Color(0.87,0.87,0)
const PINK = Color(0.88,0,0.85)
const BLUE_HAZE = Color(0.76,0.76,0.85)
const SILVER = Color(0.75,0.75,0.75)
const GREY = Color(0.5,0.5,0.5)
const DARK_GREY = Color(0.25,0.25,0.25)
const BLACK = Color(0,0,0)
const WHITE = Color(1,1,1)

var colour_timer:float = 0
var colour_counter:int = 0

var flash_counter:int = 0
var flash_effect:bool = false
var enabled:bool = true

func _process(delta):
	if enabled == true:
		if flash_effect == true:
			flash_counter += 1
			if flash_counter == 3:
				change_colour()
				flash_counter = 0
		else:
			colour_timer += delta
			if colour_timer > 3:
				colour_timer = 0
				change_colour()


func disable():
	enabled = false
	
func enable():
	enabled = true
	
	
func flash_colours():
	flash_effect = true


func clear_flash_colours():
	flash_effect = false
	
	
func change_colours(fill_colour,outline_colour,third_colour,background_colour):
	#if crash_state == false:
	VisualServer.set_default_clear_color(background_colour) 
	
	var new_colours = { 
		"outline_colour" : outline_colour,
		"fill_colour" : fill_colour,
		"third_colour" : third_colour
		}
	
	emit_signal("colours_did_change", new_colours)
	
	
func change_colour():
	colour_counter += 1
	if colour_counter > 7:
		colour_counter = 1
		
	match colour_counter:
		
		1:	change_colours(PINK, BLUE_HAZE, RED,"000000")
		2:	change_colours(DARK_BLUE, YELLOW, RED,"000000")
		3:	change_colours(PURPLE, RED, DARK_BLUE,"000000")
		4:	change_colours(GREEN, RED, PINK, "100a43")
		5:	change_colours(PINK, YELLOW, GREEN, "100a43")
		6: 	change_colours(RED, BLUE_HAZE, LIGHT_BLUE, "000000")
		7: 	change_colours(RED, DARK_BLUE, YELLOW, "000000")
