## This script is responsible for returning tilemap data by translating the
## original Scramble landscape data which is held in landscape_data.gd.
## The x position of the screen is handled in Tilemap.gd, this script reads
## two columns each time it is called and this is managed via its own pointer
## This is called from the process function in World.gd if scrolling is enabled

extends Node

signal end_of_stage_reached

onready var landscape_pointer: int = 0
onready var stage: int = 1
onready var stage_data: Array


# This dictionary maps a character code from original scramble data
# into an ID our tilemap can use
onready var tile_translations: Dictionary = {
	1:2, 2:3, 4:4, 16:14, 44:1, 45:4, 46:0, 47:2, 48:5, 49:7, 50:3, 51:6,
	52:9, 53:11, 54:8, 58:12, 92:25, 93:27, 94:24, 96:29, 97:31, 98:28,
	99:30, 209:33, 
	31:36, 27:35, 17:38, 30:37, 25:40, 29:39
}


func _ready():
	stage_data = get_data_for_stage(stage)

		
func get_runway_data() -> Array:
	var new_landscape_data: Array = []
	
	# 30 columns of runway
	for _n in range(1,31):
		new_landscape_data.append(
			{ 
				"ypos": 25,
				"outer_tile_id": 8,
				"inner_tile_id": 14,
				"position": "bottom"
			}
		)	
	return new_landscape_data
	
			
func get_landscape_data() -> Dictionary:
	var landscape_top_data: Array = []
	var landscape_bottom_data: Array = []
			
	if landscape_has_ceiling() == true:
		for data in decode_landscape_top():
			landscape_top_data.append(data)
				
	for data in decode_landscape_bottom():
		landscape_bottom_data.append(data)
	
	
	var data_to_return: Dictionary = {
		"landscape_top": landscape_top_data,
		"landscape_bottom": landscape_bottom_data,
		"ground_target": decode_ground_target(),
	}
	
	update_pointer_position()
	return data_to_return
	
	
func decode_ground_target() -> Dictionary:
	var offset = 8 if landscape_has_ceiling() else 5
	return {
		"target_id": stage_data[landscape_pointer + offset].hex_to_int(),
		"ypos": (stage_data[landscape_pointer].hex_to_int() & 248) / 8
	}
		
		
func decode_landscape_bottom() -> Array:
	return [
		{
			"ypos": (stage_data[landscape_pointer].hex_to_int() & 248) / 8,
			"outer_tile_id": get_tile(stage_data[landscape_pointer + 1].hex_to_int()),
			"inner_tile_id": 17 if stage > 3 else 14,
			"position": "bottom",
		}, 
		{
			"ypos": (stage_data[landscape_pointer + 2].hex_to_int() & 248) / 8,
			"outer_tile_id": get_tile(stage_data[landscape_pointer + 3].hex_to_int()),
			"inner_tile_id": 34 if stage > 3 else 14,
			"position": "bottom",
		}
	]
	
	
func decode_landscape_top() -> Array:
	return [
		{
			"ypos": (stage_data[landscape_pointer + 4].hex_to_int() & 248) / 8,
			"outer_tile_id": get_tile(stage_data[landscape_pointer + 5].hex_to_int()),
			"inner_tile_id": 17 if stage > 3 else 14,
			"position": "top",
		},
		{
			"ypos": (stage_data[landscape_pointer + 6].hex_to_int() & 248) / 8,
			"outer_tile_id": get_tile(stage_data[landscape_pointer + 7].hex_to_int()),
			"inner_tile_id": 34 if stage > 3 else 14,
			"position": "top",	
		}
	]


func end_of_stage_check() -> bool:
	return stage_data[landscape_pointer].hex_to_int() == 255
	
	
func landscape_has_ceiling() -> bool:
	return stage_data[landscape_pointer + 4].hex_to_int() != 0
	
	
func update_pointer_position() -> void:
	# if ceiling flag is not 0 then different offsets apply
	if landscape_has_ceiling() == true:
		landscape_pointer += 9
	else:
		landscape_pointer += 6
	# check if we have reached the end of the stage
	if end_of_stage_check() == true:
		advance_landscape_stage()


func advance_landscape_stage() -> void:
	emit_signal("end_of_stage_reached", stage)
	stage += 1
	# landscape repeats stage 6 until base target is destroyed
	if stage > 6:
		stage = 6
	stage_data = get_data_for_stage(stage)
	landscape_pointer = 0
	
	
# return a tilemap id from scramble character code
func get_tile(id) -> int:
	if id in tile_translations:
		return tile_translations[id]
	else:
		return 14 # this should never happen
		
func stage_restart() -> void:
	landscape_pointer = 0
	
		
func restart(_stage:int = 1) -> void:
	print('restarting ' + str(_stage))
	stage = _stage 
	stage_data = get_data_for_stage(stage)
	landscape_pointer = 0
	
	
# return a stage of landscape data from landscape_data.gd (global variable)
func get_data_for_stage(stage_number) -> Array:
	match stage_number:
		1: return LandscapeData.stage_1_landscape_layout
		2: return LandscapeData.stage_2_landscape_layout
		3: return LandscapeData.stage_3_landscape_layout
		4: return LandscapeData.stage_4_landscape_layout
		5: return LandscapeData.stage_5_landscape_layout
		_: return LandscapeData.stage_6_landscape_layout
		
