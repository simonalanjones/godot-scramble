extends TileMap

signal landscape_draw_completed
signal landscape_cleared


onready var Landscape_decoder = get_node("/root/World/Landscape_manager")

# this gets called when signal given that landscape has been decoded			
func setup()->void:
	
	clear_landscape()
	
	for tile in Landscape_decoder.landscape_data:
		
		var _xpos = tile.xpos
		var _ypos = tile.ypos
		var _outer_tile_id = tile.outer_tile_id
		var _inner_tile_id = tile.inner_tile_id
		var _position = tile.position
		
		# draw the outer tile (jagged shape tile)
		set_cell(_xpos, _ypos, _outer_tile_id)
		
		# draw the inner fill tiles
		if _position == "top":
			while not _ypos == 5:
				_ypos -= 1
				set_cell(_xpos, _ypos, _inner_tile_id)
		else:
			while not _ypos == 29:
				_ypos += 1
				set_cell(_xpos, _ypos, _inner_tile_id)
			
		emit_signal("landscape_draw_completed")
			
				
func change_colours(colours)->void:
	get_material().set_shader_param("fill", colours["fill_colour"])
	get_material().set_shader_param("outline", colours["outline_colour"])


# when we restart the stage we'll need to clear the landscape as
# we put a runway before the stage being restarted
func clear_landscape()->void:
	for tile in get_used_cells():
		set_cell(tile[0],tile[1],-1)
	emit_signal('landscape_cleared')
