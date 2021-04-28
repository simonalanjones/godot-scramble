extends Node

signal colours_did_change

const MAX_COLOUR_CHANGES = 7
const SECONDS_BETWEEN_CHANGES = 9
const WAIT_CYCLES_BETWEEN_FLASHES = 3

var colour_change_elapsed_time:float
var colour_change_counter: int

var flash_counter: int
var flash_effect: bool
var enabled: bool


func init():
	colour_change_elapsed_time = 0
	flash_counter = 0
	flash_effect = false
	enabled = false
	colour_change_counter = 1 # start on first colour
	
	
func _process(delta: float) -> void:
	if enabled == true:
		if flash_effect == true:
			flash_counter += 1
			if flash_counter == WAIT_CYCLES_BETWEEN_FLASHES:
				change_colour()
				flash_counter = 0
		else:
			colour_change_elapsed_time += delta
			if colour_change_elapsed_time >= SECONDS_BETWEEN_CHANGES:
				colour_change_elapsed_time = 0
				change_colour()


func disable() -> void:
	colour_change_elapsed_time = 0
	colour_change_counter = 1
	enabled = false
	
	
func enable() -> void:
	colour_change_elapsed_time = 0
	colour_change_counter = 1
	enabled = true
	
	
func flash_colours() -> void:
	flash_effect = true


func clear_flash_colours() -> void:
	flash_effect = false
	colour_change_counter = 1
	VisualServer.set_default_clear_color("000000")
	
	
func change_colours(fill_colour,outline_colour,third_colour,background_colour) -> void:
	VisualServer.set_default_clear_color(background_colour) 
	
	var new_colours = { 
		"outline_colour" : outline_colour,
		"fill_colour" : fill_colour,
		"third_colour" : third_colour
		}
	
	emit_signal("colours_did_change", new_colours)
	
	
func change_colour() -> void:
	colour_change_counter += 1
	if colour_change_counter > MAX_COLOUR_CHANGES:
		colour_change_counter = 1
		
	match colour_change_counter:
		
		1:	change_colours(colours.pink, colours.blue_haze, colours.red, "000000")
		2:	change_colours(colours.dark_blue, colours.yellow, colours.red, "000000")
		3:	change_colours(colours.purple, colours.red, colours.dark_blue,"000000")
		4:	change_colours(colours.green, colours.red, colours.pink, "100a43")
		5:	change_colours(colours.pink, colours.yellow, colours.green, "100a43")
		6: 	change_colours(colours.red, colours.blue_haze, colours.light_blue, "000000")
		7: 	change_colours(colours.red, colours.dark_blue, colours.yellow, "000000")
