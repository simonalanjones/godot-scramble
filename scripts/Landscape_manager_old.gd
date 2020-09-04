extends Node

#warning-ignore:unused_signal
signal landscape_decoded

var rocket_positions:Array = []
var fuel_positions:Array = []
var mystery_positions:Array = []
var base_positions:Array = []
var landscape_data:Array = []

var xpos:int = 0


#new vars
onready var new_pointer = 0
onready var new_stage = 1
onready var stage_data = LandscapeData.stage_1_landscape_layout



func get_runway_data():
	var new_landscape_data:Array = []
	
	for n in range(30):
		new_landscape_data.append({ 
			'ypos' : 25,
			'outer_tile_id' : 8,
			'inner_tile_id' : 14,
			'position' : 'bottom'
			})	
		
	return new_landscape_data
			
			
# new funcs

func decode_landscape_bottom():
	# fill code is the tile id that sit below/up outline		
	var first_fill_code = 17 if new_stage > 3 else 14
	var second_fill_code = 34 if new_stage > 3 else 14
	
	# y position bottom
	var first_y = (stage_data[new_pointer+0].hex_to_int() & 248) / 8
	# y position bottom
	var second_y = (stage_data[new_pointer+2].hex_to_int() & 248) / 8
		
	# character code bottom
	var first_sprite_code =  get_tile(stage_data[new_pointer+1].hex_to_int())
	# character code bottom
	var second_sprite_code = get_tile(stage_data[new_pointer+3].hex_to_int())
	
	var bottom_landscape_data:Array = []
	
	bottom_landscape_data.append({ 
			'ypos' : first_y,
			'outer_tile_id' : first_sprite_code,
			'inner_tile_id' : 17 if new_stage > 3 else 14,
			'position' : 'bottom'
			})
				
	bottom_landscape_data.append({ 
			'ypos' : second_y,
			'outer_tile_id' : second_sprite_code,
			'inner_tile_id' : 17 if new_stage > 3 else 14,
			'position' : 'bottom'
			})
	print (bottom_landscape_data)
	return bottom_landscape_data
	



func decode_landscape_top():
	#ground_target_code = stage_data[new_pointer+8].hex_to_int()
	
	# fill code is the tile id that sit below/up outline		
	var first_fill_code = 17 if new_stage > 3 else 14
	var second_fill_code = 34 if new_stage > 3 else 14
	
	var top_landscape_data:Array = []
				
	var third_y = (stage_data[new_pointer + 4].hex_to_int() & 248) / 8
	var fourth_y = (stage_data[new_pointer + 6].hex_to_int() & 248) / 8

	# character code top
	var third_sprite_code = get_tile(stage_data[new_pointer+5].hex_to_int())
	# character code top		
	var fourth_sprite_code =  get_tile(stage_data[new_pointer+7].hex_to_int())
			
	top_landscape_data.append({ 
		'ypos' : third_y,
		'outer_tile_id' : third_sprite_code,
		'inner_tile_id' : first_fill_code,
		'position' : 'top',
		})
			
	top_landscape_data.append({ 
		'ypos' : fourth_y,
		'outer_tile_id' : fourth_sprite_code,
		'inner_tile_id' : second_fill_code,
		'position' : 'top',
		})
	
	print (top_landscape_data)
	return top_landscape_data


func end_of_stage_check() -> bool:
	return stage_data[new_pointer].hex_to_int() == 255
	
	
func landscape_has_ceiling_check() -> bool:
	return stage_data[new_pointer+4].hex_to_int() != 0
	
	
func update_pointer_position() -> void:
	if landscape_has_ceiling_check() == true:
		new_pointer += 9
	else:
		new_pointer += 6


func advance_landscape_stage() -> void:
	new_stage += 1
	if new_stage > 6:
		new_stage = 6
	stage_data = get_data_for_stage(new_stage)
	new_pointer = 0
		

func get_data_from_stage():
	# check we haven't reached end of landscape stage
	if end_of_stage_check() == true:
		advance_landscape_stage()
		
	var new_landscape_data:Array = []
	
	if landscape_has_ceiling_check() == true:
		for data in decode_landscape_top():
			new_landscape_data.append(data)
				
	for data in decode_landscape_bottom():
		new_landscape_data.append(data)
			
	# update pointer depending if top data encoded	
	# if ceiling flag is not 0 then different offsets apply
	update_pointer_position()
	return new_landscape_data


func get_decoded_data():
	return landscape_data
	
	
func restart(stage)->void:
	# clear previous end stage markers		
	for node in get_tree().get_nodes_in_group("stage_clear_markers"):
		node.queue_free()
	
	# clear previous ground targets	
	rocket_positions.clear()
	fuel_positions.clear()
	mystery_positions.clear()
	base_positions.clear()
	
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






func add_runway_to_landscape():
	# we're going to draw 30 columns 
	for n in range(30):
		xpos += 1
				
		landscape_data.append({ 
			'xpos' : n, 
			'ypos' : 25,
			'outer_tile_id' : 8,
			'inner_tile_id' : 14,
			'position' : 'bottom'
			})		

		
func decode_landscape_stage(stage:int, draw_runway:bool = false)->void:
	
	var landscape:Array = get_data_for_stage(stage)
	
	var pointer:int = 0
	var ground_target_code:int
	var first_fill_code:int
	var second_fill_code:int

	if draw_runway == true:
		add_runway_to_landscape()

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
			
			landscape_data.append({ 
				'xpos' : xpos, 
				'ypos' : third_y,
				'outer_tile_id' : third_sprite_code,
				'inner_tile_id' : first_fill_code,
				'position' : 'top'
				})
			
			landscape_data.append({ 
				'xpos' : xpos+1, 
				'ypos' : fourth_y,
				'outer_tile_id' : fourth_sprite_code,
				'inner_tile_id' : second_fill_code,
				'position' : 'top'
				})
			
			pointer += 9
		else:
			ground_target_code = landscape[pointer+5].hex_to_int()
			pointer += 6
		
		if not ground_target_code == 0:
			add_ground_target(ground_target_code, xpos, first_y - 2)
			
		landscape_data.append({ 
				'xpos' : xpos, 
				'ypos' : first_y,
				'outer_tile_id' : first_sprite_code,
				'inner_tile_id' : first_fill_code,
				'position' : 'bottom'
				})
				
		landscape_data.append({ 
				'xpos' : xpos+1, 
				'ypos' : second_y,
				'outer_tile_id' : second_sprite_code,
				'inner_tile_id' : second_fill_code,
				'position' : 'bottom'
				})
				
		# we read two tile positions at a time so advance screen x +2
		xpos += 2
	
	
	var end_position = (Vector2(xpos*8,1))
	
	# add a stage clear marker at end of stage landscape
	var node = VisibilityNotifier2D.new()
	var funcname = "stage"+str(stage)+"_end"
	if stage == 6:
		end_position.x += 150
	node.set_global_position(Vector2(end_position.x,end_position.y))
	node.connect('screen_entered',get_node("/root/World/"),funcname)
	node.add_to_group('stage_clear_markers')
	get_node("/root/World/").call_deferred("add_child", node)
	

func add_ground_target(target_id,x_pos,y_pos)->void:
	match target_id:
		1: rocket_positions.append(Vector2(x_pos,y_pos))
		2: fuel_positions.append(Vector2(x_pos,y_pos))
		4: mystery_positions.append(Vector2(x_pos,y_pos))
		8: base_positions.append(Vector2(x_pos,y_pos))
		
		
# return a tilemap id from scramble character code
func get_tile(id)->int:
	if id in tile_translations:
		return tile_translations[id]
	else:
		return 14 # this should never happen
		
		
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
	99:30,209:33, 
	31:36, 27:35, 17:38, 30:37, 25:40, 29:39
}


func get_rocket_positions()->Array:
	return rocket_positions


func get_mystery_positions()->Array:
	return mystery_positions
	
	
func get_fuel_positions()->Array:
	return fuel_positions
	
	
func get_base_positions()->Array:
	return base_positions
	
	
func get_landscape()->Array:
	return landscape_data
