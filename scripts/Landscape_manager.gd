## This script is responsible for returning tilemap data by translating the
## original Scramble landscape data which is held in landscape_data.gd.

extends Node2D

onready var Tilemap = get_node("Tilemap")
onready var Containers = get_node("Containers")
onready var Landscape_decoder = get_node("Landscape_decoder")
onready var tilemap_xpos = 0
onready var process_counter = 0


func draw_runway() -> void:
	var runway_data = Landscape_decoder.get_runway_data()
	while tilemap_xpos < 30:
		Tilemap.update_landscape(runway_data, tilemap_xpos)
		tilemap_xpos += 2


func reset() -> void:
	Landscape_decoder.set_stage(1)
	Landscape_decoder.landscape_pointer = 0
	tilemap_xpos = 0
	process_counter = 0


func stage_restart() -> void:
	Landscape_decoder.landscape_pointer = 0
	tilemap_xpos = 0
	process_counter = 0
	
	
func update_landscape() -> void:
	if tilemap_xpos >= 30:
		process_counter += 1
		if process_counter >= 16:
			process_counter = 0
			
			var landscape_data = Landscape_decoder.get_landscape_data()
			Tilemap.update_landscape(landscape_data, tilemap_xpos)
			Containers.update_ground_targets(landscape_data.ground_target, tilemap_xpos)
			tilemap_xpos += 2
