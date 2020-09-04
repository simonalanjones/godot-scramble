extends TileMap

func draw_runway(runway_data: Array) -> void:
	var xpos = 0
	for r in runway_data:
		render_tile_column(r, xpos)
		xpos += 1

	
func update_landscape(tiles, new_xpos: int) -> void:
	var landscape_top = tiles.landscape_top
	var landscape_bottom = tiles.landscape_bottom
	
	if landscape_top.size()>0:
		render_tile_column(landscape_top[0],new_xpos)
		render_tile_column(landscape_top[1],new_xpos+1)

	render_tile_column(landscape_bottom[0],new_xpos)
	render_tile_column(landscape_bottom[1],new_xpos+1)

		
func render_tile_column(data, new_xpos: int) -> void:
	var _outer_tile_id = data.outer_tile_id
	var _inner_tile_id = data.inner_tile_id
	var _xpos = new_xpos
	var _ypos = int(data.ypos)
	var _position = data.position

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
			
				
func change_colours(colours) -> void:
	get_material().set_shader_param("fill", colours["fill_colour"])
	get_material().set_shader_param("outline", colours["outline_colour"])


# when we restart the stage or complete the mission
# we'll need to clear the landscape
func clear_landscape() -> void:
	for tile in get_used_cells():
		set_cell(tile[0],tile[1],-1)
