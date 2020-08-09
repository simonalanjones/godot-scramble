extends Node

#warning-ignore:unused_signal
signal landscape_decoded

var rocket_positions:Array = []
var fuel_positions:Array = []
var mystery_positions:Array = []
var landscape_data:Array = []

var xpos:int = 0


func restart(stage)->void:
	# clear previous end stage markers		
	for node in get_tree().get_nodes_in_group("stage_clear_markers"):
		node.queue_free()
	
	# clear previous ground targets	
	rocket_positions.clear()
	fuel_positions.clear()
	mystery_positions.clear()
	
	#clear previous tilemap landscape data
	landscape_data.clear()

	# reset the draw x position
	xpos = 0
	
	# pass back to setup routine
	setup(stage)
	
	
func setup(s = 1)->void:
	for stage in range(s, 7):
		# the first stage in the draw loop gets a runway
		var draw_runway = true if stage == s else false
		decode_landscape_stage(stage,draw_runway)
	# delay the execution to wait for connections in World node	
	call_deferred("emit_signal","landscape_decoded")
		
		
func decode_landscape_stage(stage:int, draw_runway:bool = false)->void:
	
	var landscape:Array = get_data_for_stage(stage)
	
	var pointer:int = 0
	var ground_target_code:int
	var first_fill_code:int
	var second_fill_code:int

	if draw_runway == true:
		# we're going to draw 30 columns 
		for n in range(30):
			xpos += 1
			
			var _d = { 
				'xpos' : n, 
				'ypos' : 25,
				'outer_tile_id' : 8,
				'inner_tile_id' : 14,
				'position' : 'bottom'
				}
				
			landscape_data.append(_d)
	
	# fill code is the tile id that sit below/up outline		
	first_fill_code = 17 if stage > 3 else 14
	second_fill_code = 34 if stage > 3 else 14
	
	# 0xFF is the end of landscape marker
	while not landscape[pointer].hex_to_int() == 255:
		
		# y position bottom
		var first_y = (landscape[pointer+0].hex_to_int() & 248) / 8
		# y position bottom
		var second_y = (landscape[pointer+2].hex_to_int() & 248) / 8	
		
		# character code bottom
		var first_sprite_code =  get_tile(landscape[pointer+1].hex_to_int()) 
		# character code bottom
		var second_sprite_code = get_tile(landscape[pointer+3].hex_to_int()) 
		
		# used to signify ceiling if not 0
		var ceiling_flag = landscape[pointer+4].hex_to_int() 
		
		# if ceiling flag is not 0 then different offsets apply
		if not ceiling_flag == 0:
			ground_target_code = landscape[pointer+8].hex_to_int()
			
			var third_y = (landscape[pointer+4].hex_to_int() & 248) / 8
			var fourth_y = (landscape[pointer+6].hex_to_int() & 248) / 8

			# character code top
			var third_sprite_code = get_tile(landscape[pointer+5].hex_to_int())
			# character code top		
			var fourth_sprite_code =  get_tile(landscape[pointer+7].hex_to_int())
			
			var _d1 = { 
				'xpos' : xpos, 
				'ypos' : third_y,
				'outer_tile_id' : third_sprite_code,
				'inner_tile_id' : first_fill_code,
				'position' : 'top'
				}
				
			landscape_data.append(_d1)
			
			var _d2 = { 
				'xpos' : xpos+1, 
				'ypos' : fourth_y,
				'outer_tile_id' : fourth_sprite_code,
				'inner_tile_id' : second_fill_code,
				'position' : 'top'
				}
			
			landscape_data.append(_d2)
			
			pointer += 9
		else:
			ground_target_code = landscape[pointer+5].hex_to_int()
			pointer += 6
		
		if not ground_target_code == 0:
			add_ground_target(ground_target_code, xpos, first_y - 2)
			
		
		var _d1 = { 
				'xpos' : xpos, 
				'ypos' : first_y,
				'outer_tile_id' : first_sprite_code,
				'inner_tile_id' : first_fill_code,
				'position' : 'bottom'
				}
				
		landscape_data.append(_d1)
		
		var _d2 = { 
				'xpos' : xpos+1, 
				'ypos' : second_y,
				'outer_tile_id' : second_sprite_code,
				'inner_tile_id' : second_fill_code,
				'position' : 'bottom'
				}
		landscape_data.append(_d2)
				
		# we read two tile positions at a time so advance screen x +2
		xpos += 2
	
	
	var end_position = (Vector2(xpos*8,1))
	
	# add a stage clear marker at end of stage landscape
	var node = VisibilityNotifier2D.new()
	var funcname = "stage"+str(stage)+"_end"
	node.set_global_position(Vector2(end_position.x,end_position.y))
	node.connect('screen_entered',get_node("/root/World/"),funcname)
	node.add_to_group('stage_clear_markers')
	get_node("/root/World/").call_deferred("add_child", node)
	

func add_ground_target(target_id,x_pos,y_pos)->void:
	match target_id:
		1: rocket_positions.append(Vector2(x_pos,y_pos))
		2: fuel_positions.append(Vector2(x_pos,y_pos))
		4: mystery_positions.append(Vector2(x_pos,y_pos))
		
		
# return a tilemap id from scramble character code
func get_tile(id)->int:
	if id in tile_translations:
		return tile_translations[id]
	else:
		return 14
		
		
# return a stage of landscape data from landscape_data.gd (global variable)
func get_data_for_stage(stage)->Array:
	match stage:
		1: return LandscapeData.stage_1_landscape_layout
		2: return LandscapeData.stage_2_landscape_layout
		3: return LandscapeData.stage_3_landscape_layout
		4: return LandscapeData.stage_4_landscape_layout
		5: return LandscapeData.stage_5_landscape_layout
		_: return LandscapeData.stage_6_landscape_layout
		
		
# this dictionary maps character codes from original scramble data
# into landscape tilemap ids
var tile_translations = {
	1:2, 2:3, 4:4, 16:14, 44:1, 45:4, 46:0, 47:2, 48:5, 49:7, 50:3, 51:6,
	52:9, 53:11, 54:8, 58:12, 92:25, 93:27, 94:24, 96:29, 97:31, 98:28,
	99:30,209:33
}


func get_rocket_positions()->Array:
	return rocket_positions


func get_mystery_positions()->Array:
	return mystery_positions
	
	
func get_fuel_positions()->Array:
	return fuel_positions
	
	
func get_landscape()->Array:
	return landscape_data
