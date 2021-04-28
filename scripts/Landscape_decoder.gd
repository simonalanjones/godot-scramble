extends Node

signal stage1_completed
signal stage2_completed
signal stage3_completed
signal stage4_completed
signal stage5_completed


onready var landscape_pointer: int = 0
onready var stage: int = 1
onready var stage_data: Array = []
onready var Landscape_data = get_node("Landscape_data")
onready var target_count: int = 0 # not used

# original scramble landscape data includes a code for each landscape sprite
# this dictionary converts those values to a tilemap tile id
onready var tile_translations: Dictionary = {
	1:2, 2:3, 4:4, 16:14, 44:1, 45:4, 46:0, 47:2, 48:5, 49:7, 50:3, 51:6,
	52:9, 53:11, 54:8, 58:12, 92:25, 93:27, 94:24, 96:29, 97:31, 98:28,
	99:30, 209:33, 31:36, 27:35, 17:38, 30:37, 25:40, 29:39
}
	
	
func _ready():
	landscape_pointer = 0
	stage_data = Landscape_data.get_data_for_stage(stage)
	
	
func set_stage(_stage: int) -> void:
	stage = _stage
	stage_data = Landscape_data.get_data_for_stage(stage)
	

func get_stage() -> int:
	return stage


# not used but useful if you wanted to know how many
# ground targets on current stage - possible achievement
func count_of_stage_targets() -> int:
	var _temp = landscape_pointer
	landscape_pointer = 0
	stage_data = Landscape_data.get_data_for_stage(stage)
	target_count = 0

	while not end_of_stage_check():
		var _d = get_landscape_data()
		var _t = _d.ground_target
		if _t.target_id != 0:
			target_count += 1
		landscape_pointer += 9 if landscape_has_ceiling() else 6

	landscape_pointer = _temp
	return target_count


func get_runway_data() -> Dictionary:
	var landscape_bottom_data = [
		{
			"ypos": 25,
			"outer_tile_id": 8,
			"inner_tile_id": 14,
			"position": "bottom",
		}, 
		{
			"ypos": 25,
			"outer_tile_id": 8,
			"inner_tile_id": 14,
			"position": "bottom",
		}
	]
	
	return {
		"landscape_top": [],
		"landscape_bottom": landscape_bottom_data,
		"ground_target": [],
	}
	
	
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


func decode_landscape_bottom() -> Array:
	return [
		{
			"ypos": (stage_data[landscape_pointer].hex_to_int() & 248) / 8,
			"outer_tile_id": tile_translations[stage_data[landscape_pointer + 1].hex_to_int()],
			"inner_tile_id": 17 if stage > 3 else 14,
			"position": "bottom",
		}, 
		{
			"ypos": (stage_data[landscape_pointer + 2].hex_to_int() & 248) / 8,
			"outer_tile_id": tile_translations[stage_data[landscape_pointer + 3].hex_to_int()],
			"inner_tile_id": 34 if stage > 3 else 14,
			"position": "bottom",
		}
	]

func decode_landscape_top() -> Array:
	return [
		{
			"ypos": (stage_data[landscape_pointer + 4].hex_to_int() & 248) / 8,
			"outer_tile_id": tile_translations[stage_data[landscape_pointer + 5].hex_to_int()],
			"inner_tile_id": 17 if stage > 3 else 14,
			"position": "top",
		},
		{
			"ypos": (stage_data[landscape_pointer + 6].hex_to_int() & 248) / 8,
			"outer_tile_id": tile_translations[stage_data[landscape_pointer + 7].hex_to_int()],
			"inner_tile_id": 34 if stage > 3 else 14,
			"position": "top",	
		}
	]


func decode_ground_target() -> Dictionary:
	var offset = 8 if landscape_has_ceiling() else 5
	return {
		"target_id": stage_data[landscape_pointer + offset].hex_to_int(),
		"ypos": (stage_data[landscape_pointer].hex_to_int() & 248) / 8
	}
	
	
func end_of_stage_check() -> bool:
	return stage_data[landscape_pointer].hex_to_int() == 255
	
	
func landscape_has_ceiling() -> bool:
	return stage_data[landscape_pointer + 4].hex_to_int() != 0
	
	
func update_pointer_position() -> void:
	# if ceiling flag is not 0 then different offsets apply
	landscape_pointer += 9 if landscape_has_ceiling() else 6
	# check if we have reached the end of the stage
	if end_of_stage_check() == true:
		advance_landscape_stage()


func advance_landscape_stage() -> void:
	match stage:
		1: emit_signal("stage1_completed")
		2: emit_signal("stage2_completed")
		3: emit_signal("stage3_completed")
		4: emit_signal("stage4_completed")
		5: emit_signal("stage5_completed")
				
	stage += 1
	# landscape repeats stage 6 until base target is destroyed
	if stage > 6:
		stage = 6
	stage_data = Landscape_data.get_data_for_stage(stage)
	landscape_pointer = 0
