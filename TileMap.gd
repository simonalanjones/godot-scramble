extends TileMap


signal colours_did_change

# build an array of data from tilemap and store
# later build tilemap from crash position by locating tilemap data
# with positions greater than start and build a tilemap from that
# Need data from demo tilemap to store first and then dynamically build tilemap from
# saved data
# have source tilemap and active_map?

var colour_counter = 0
	
func _ready():
	change_colour()
	VisualServer.set_default_clear_color("000000") #background set to black

func change_colours(fill_colour,outline_colour,third_colour,background_colour):
	get_material().set_shader_param("fill", fill_colour)
	get_material().set_shader_param("outline", outline_colour)
	VisualServer.set_default_clear_color(background_colour) 
	
	var new_colours = { 
		"outline_colour" : outline_colour,
		"fill_colour" : fill_colour,
		"third_colour" : third_colour
		}
		
	emit_signal("colours_did_change", new_colours)

	
func change_colour():
	colour_counter+=1
	if colour_counter > 7:
		colour_counter = 1
		
	match colour_counter:
		
		1:	change_colours(colours.pink,colours.blue_haze,colours.red,"000000")
		2:	change_colours(colours.dark_blue,colours.yellow,colours.red,"000000")
		3:	change_colours(colours.purple,colours.red,colours.dark_blue,"000000")
		4:	change_colours(colours.green,colours.red,colours.pink,"100a43" )
		5:	change_colours(colours.pink,colours.yellow,colours.green,"100a43")
		6: 	change_colours(colours.red,colours.blue_haze,colours.light_blue,"000000")
		7: 	change_colours(colours.red,colours.dark_blue,colours.yellow,"000000")