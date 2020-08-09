extends TileMap


signal colours_did_change
export var is_scrolling:bool = true
var crash_state = false
var crash_colour_counter = 0



# build an array of data from tilemap and store
# later build tilemap from crash position by locating tilemap data
# with positions greater than start and build a tilemap from that
# Need data from demo tilemap to store first and then dynamically build tilemap from
# saved data
# have source tilemap and active_map?

var colour_counter = 0

func load_tilemap():
	var save_game = File.new()
	if not save_game.file_exists("user://landscape.save"):
		print('error opening save game')
	var file = File.new()
	file.open("user://landscape.save", file.READ)
	var json = file.get_as_text()
	var json_result = JSON.parse(json).result
	for entry in json_result:
	#	print(entry)
		var xpos = entry[0]
		var ypos = entry[1]
		var tile_id = entry[2]
		$Landscape2.set_cell(xpos, ypos, tile_id)
	
func __ready():
	change_colour()
	



func set_crash_state():
	crash_state = true
	is_scrolling = false

	
func clear_crash_state():
	crash_state = false

		
func __process(_delta):
	if is_scrolling == true:
		#$Camera2D.position.x += 1
		pass
	if crash_state == true:
		crash_colour_counter += 1
		if crash_colour_counter == 5:
			crash_colour_counter = 0
			change_colour()
		
		
func disable_scrolling():
	is_scrolling = false
	
func enable_scrolling():
	is_scrolling = true
	
func change_colours(fill_colour,outline_colour,third_colour,background_colour):
	#landscape doesn't use third colour
	get_material().set_shader_param("fill", fill_colour)
	get_material().set_shader_param("outline", outline_colour)
	if crash_state == false:
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
