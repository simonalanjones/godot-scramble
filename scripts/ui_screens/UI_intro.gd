extends "res://scripts/ui_screens/UI_view.gd"
tool

const HEADER_TEXT_L1 = "PLAY"
const HEADER_TEXT_L1_COLOUR = "ffff00"
const HEADER_TEXT_L1_ROWS_ABOVE = 9
const HEADER_TEXT_L1_ROWS_BELOW = 2

const HEADER_TEXT_L2 = "- SCRAMBLE -"
const HEADER_TEXT_L2_COLOUR = "00c3d9"
const HEADER_TEXT_L2_ROWS_ABOVE = 0

const MIDDLE_TEXT_L1 = "HOW FAR CAN YOU INVADE"
const MIDDLE_TEXT_L2 = "OUR SCRAMBLE SYSTEM ?"
const MIDDLE_TEXT_COLOUR = "ff0000"
const MIDDLE_TEXT_L1_ROWS_ABOVE = 5
const MIDDLE_TEXT_L2_ROWS_ABOVE = 2

#const FOOTER_TEXT_L1 = "GAME BY SIMON JONES 2020"
const FOOTER_TEXT_L1 = "PRESS %s TO START"
const FOOTER_TEXT_L1_ROWS_ABOVE = 7
const FOOTER_TEXT_L1_ROWS_BELOW = 1

const FOOTER_TEXT_L2 = "OR ESC FOR SETTINGS"
const FOOTER_TEXT_COLOUR = "ffffff"

const COLOUR_HEADING = "e03d00"
const COLOUR_KEY_ACTIONS = "f5eb14"
const COLOUR_KEY_LABELS = "ffffff"



func _ready():
	
	var mc1 = make_margin_container_label({ 
		"label_text" : HEADER_TEXT_L1,
		"label_colour" : HEADER_TEXT_L1_COLOUR,
		"margin_top" : HEADER_TEXT_L1_ROWS_ABOVE,
		"margin_bottom" : HEADER_TEXT_L1_ROWS_BELOW
	})
	
	var mc2 = make_margin_container_label( { 
		"label_text" : HEADER_TEXT_L2,
		"label_colour" : HEADER_TEXT_L2_COLOUR,
		"margin_top" : HEADER_TEXT_L2_ROWS_ABOVE
	})

	var mc3 = make_margin_container_label( { 
		"label_text" : MIDDLE_TEXT_L1,
		"label_colour" : MIDDLE_TEXT_COLOUR,
		"margin_top" : MIDDLE_TEXT_L1_ROWS_ABOVE
	})	

	var mc4 = make_margin_container_label( { 
		"label_text" : MIDDLE_TEXT_L2,
		"label_colour" : MIDDLE_TEXT_COLOUR,
		"margin_top" : MIDDLE_TEXT_L2_ROWS_ABOVE
	})
	
	var mc5 = make_margin_container_label( { 
		"label_text" : FOOTER_TEXT_L1 % get_input_action_text("start"),
		"label_colour" : FOOTER_TEXT_COLOUR,
		"margin_top" : FOOTER_TEXT_L1_ROWS_ABOVE,
		"margin_bottom" : FOOTER_TEXT_L1_ROWS_BELOW
	})
	
	var mc6 = make_margin_container_label( { 
		"label_text" : FOOTER_TEXT_L2,
		"label_colour" : FOOTER_TEXT_COLOUR
	})
	
		
	add_to_head(mc1)
	add_to_head(mc2)
	add_to_head(mc3)
	add_to_head(mc4)
	add_to_head(mc5)
	add_to_head(mc6)
	render()
	
	
	render_view({
		'head': { 
			'items': [mc1,mc2],
		},
		'body': {
			'items' : [mc1,mc2]
		}
	})
	
