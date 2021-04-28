extends "res://scripts/ui_screens/UI_view.gd"
tool

const HEADER_TEXT_L1 = "CONGRATULATIONS"
const HEADER_TEXT_L1_COLOUR = "ffffff"
const HEADER_TEXT_L2 = "YOU COMPLETED YOUR DUTIES"
const HEADER_TEXT_L2_COLOUR = "ffff00"
const HEADER_TEXT_L3 = "GOOD LUCK NEXT TIME AGAIN"
const HEADER_TEXT_L3_COLOUR = "00c2d9"

func _ready():
	var mc1 = make_container_label(HEADER_TEXT_L1, HEADER_TEXT_L1_COLOUR)
	mc1.set("custom_constants/margin_top", 96)
	mc1.set("custom_constants/margin_bottom", 8)
	add_to_body(mc1)
	
	var mc2 = make_container_label(HEADER_TEXT_L2, HEADER_TEXT_L2_COLOUR)
	mc2.set("custom_constants/margin_bottom", 8)
	add_to_body(mc2)
	
	var mc3 = make_container_label(HEADER_TEXT_L3, HEADER_TEXT_L3_COLOUR)
	#mc3.set("custom_constants/margin_top", 16)
	add_to_body(mc3)
	
	render()
