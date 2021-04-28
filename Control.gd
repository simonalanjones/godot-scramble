extends Control
tool

const HEADER_TEXT = "- KEYBOARD CONTROLS -"
const FOOTER_TEXT = "PRESS %s TO START"
const FONT_PATH = "res://PressStart2P-vaV7.ttf"

const COLOUR_HEADING = "e03d00"
const COLOUR_KEY_ACTIONS = "f5eb14"
const COLOUR_KEY_LABELS = "ffffff"
const FONT_SIZE = 8
const DOTTED_CHARS = "......................"
const MID_SECTION_MARGINS = 32
const MID_SECTION_LINE_SPACING = 8

var key_actions = [
	{ "label" : "UP", "action" : "move_up" },
	{ "label" : "DOWN", "action" : "move_down" },
	{ "label" : "LEFT", "action" : "move_left" },
	{ "label" : "RIGHT", "action" : "move_right" },
	{ "label" : "FIRE", "action" : "fire_bullet" },
	{ "label" : "BOMB", "action" : "drop_bomb" }	
]

var action_translations = { 
	"Up" : "cursor up",
	"Down" : "cursor down",
	"Left" : "cursor left",
	"Right" : "cursor right",
	}


var mid_mc = MarginContainer.new()
var top_mc = MarginContainer.new()
var outer_vbox = VBoxContainer.new()
var top_vbox = VBoxContainer.new()
var mid_vbox = VBoxContainer.new()
var bot_vbox = VBoxContainer.new()

var label_heading = Label.new()
var label_bot_heading = Label.new()
var dynamic_font = DynamicFont.new()
var line_count = 0


func _ready():
	
	dynamic_font.font_data = load(FONT_PATH)
	dynamic_font.size = 8
	
	# main container holding top, middle, and bottom sections
	outer_vbox.set_anchors_preset(Control.PRESET_WIDE)
	outer_vbox.set("custom_constants/separation", 0)
	
	# top section margin container values set
	top_mc.set("custom_constants/margin_top", 48)
	top_mc.set("custom_constants/margin_bottom", 48)
	
	# add top vbox container to top margin container
	top_mc.add_child(top_vbox)
	
	# top section header text
	label_heading.set("custom_fonts/font", dynamic_font)
	label_heading.set_text(HEADER_TEXT)
	label_heading.set("custom_colors/font_color", COLOUR_HEADING)
	label_heading.set_align(Label.ALIGN_CENTER)
	
	top_vbox.add_child(label_heading)
	
	# mid section box container values set
	mid_vbox.set("custom_constants/separation", MID_SECTION_LINE_SPACING)
	
	# mid section margin container values set
	mid_mc.set("custom_constants/margin_left", MID_SECTION_MARGINS)
	mid_mc.set("custom_constants/margin_right", MID_SECTION_MARGINS)
	mid_mc.add_child(mid_vbox)
	mid_mc.set_v_size_flags(Control.SIZE_EXPAND_FILL)
	
	
	
	# mid section with key actions
	for action_row in key_actions:
		
		var hbox = HBoxContainer.new()
		
		# add an empty container between direction and fire keys
		if line_count == 4:
			mid_vbox.add_child(HBoxContainer.new())
		
		line_count += 1	
		hbox.set("custom_constants/separation", 0)
		
		# generate a label with input event (the action) on left side of hbox	
		var label_left = Label.new()
		label_left.set("custom_fonts/font", dynamic_font)
		label_left.set("custom_colors/font_color", COLOUR_KEY_LABELS)
		label_left.set_text(action_row.label)
		hbox.add_child(label_left)

		# generate a dotted line label in the middle of hbox
		var label_dots = Label.new()
		label_dots.set("custom_fonts/font", dynamic_font)
		label_dots.set("custom_colors/font_color", COLOUR_KEY_LABELS)
		label_dots.clip_text = true
		label_dots.set_text(DOTTED_CHARS)
		label_dots.set_h_size_flags(Control.SIZE_EXPAND_FILL)
		hbox.add_child(label_dots)	
		
		# generate a label with input event (the key) on right side of hbox
		var label_right = Label.new()
		label_right.set("custom_fonts/font", dynamic_font)
		label_right.set_align(Label.ALIGN_RIGHT)
		label_right.uppercase = true
		label_right.set("custom_colors/font_color", COLOUR_KEY_ACTIONS)
		label_right.set_text(get_input_action_text(action_row.action))
		hbox.add_child(label_right)
		mid_vbox.add_child(hbox)
		
	
	# generate a label with input key to start game
	label_bot_heading.set("custom_fonts/font", dynamic_font)
	label_bot_heading.set_text(FOOTER_TEXT % get_input_action_text("start"))
	label_bot_heading.uppercase = true
	label_bot_heading.set_align(Label.ALIGN_CENTER)
	bot_vbox.add_child(label_bot_heading)
	
	# add all child containers to outer container
	outer_vbox.add_child(top_mc)
	outer_vbox.add_child(mid_mc)
	outer_vbox.add_child(bot_vbox)
	
	# complete outer container to screen
	add_child(outer_vbox)


# check the input map for a given input_action
# and return first matching input event
func get_input_action_text(input_action: String) -> String:
	
	if InputMap.has_action(input_action):
		var action_list = InputMap.get_action_list(input_action)
		var action_text = action_list[0].as_text()
				
		var input_action_text
		if action_text in action_translations:
			input_action_text = action_translations.get(action_text)
		else:
			input_action_text = action_text
		
		return input_action_text
	else:
		return "N/A"
