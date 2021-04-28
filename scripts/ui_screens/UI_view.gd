extends Control

const FONT_PATH = "res://PressStart2P-vaV7.ttf"
const FONT_SIZE = 8
const SCREEN_WIDTH_PIXELS = 224.0
const WHITE_COLOUR = "ffffff"

var dynamic_font: DynamicFont

var head_container: Container
var body_container: Container
var footer_container: Container

var key_actions = [
	{ "label" : "UP", "action" : "move_up" },
	{ "label" : "DOWN", "action" : "move_down" },
	{ "label" : "LEFT", "action" : "move_left" },
	{ "label" : "RIGHT", "action" : "move_right" },
	{ "label" : "FIRE", "action" : "fire_bullet" },
	{ "label" : "BOMB", "action" : "drop_bomb" }	
]

var action_translations = { 
	"Up" : "W", #cursor up",
	"Down" : "cursor down",
	"Left" : "cursor left",
	"Right" : "cursor right",
	}
	

func _ready():
	dynamic_font = DynamicFont.new()
	dynamic_font.font_data = load(FONT_PATH)
	dynamic_font.size = FONT_SIZE
	
	head_container = VBoxContainer.new()
	head_container.set("custom_constants/separation", 0)
	
	body_container = VBoxContainer.new()
	body_container.set("custom_constants/separation", 0)
	
	footer_container = VBoxContainer.new()
	footer_container.set("custom_constants/separation", 0)


func add_to_head(container: Container):
	head_container.add_child(container)


func add_to_body(container: Container):
	body_container.add_child(container)
	
	
func add_to_footer(container: Container):
	footer_container.add_child(container)


func render():
	var outer_container = VBoxContainer.new()
	outer_container.set_h_size_flags(Control.SIZE_EXPAND_FILL)
	outer_container.set_v_size_flags(Control.SIZE_EXPAND_FILL)
	
	outer_container.set("custom_constants/separation", 0)
	body_container.set("custom_constants/separation", 0)
	outer_container.add_child(head_container)
	outer_container.add_child(body_container)
	outer_container.add_child(footer_container)
	add_child(outer_container)


func render_view(_params: Dictionary) -> void:
	pass	
	

func calc_margin_x(string: String) -> int:
	var half_screen_width: float = SCREEN_WIDTH_PIXELS / 2
	var half_string_length: float = float(string.length()) / 2
	var margin = half_screen_width - floor(half_string_length) * FONT_SIZE
	return margin
	
	
func make_label(label_text: String, label_colour: String = WHITE_COLOUR):
	var label = Label.new()
	label.set_text(label_text)
	label.set("custom_fonts/font", dynamic_font)
	label.set("custom_colors/font_color", label_colour)
	label.set_uppercase(true)
	#label.autowrap = true
	return label
	
	
func make_container_label(label_text: String, label_colour: String):
	var label = Label.new()
	label.set_text(label_text)
	label.set("custom_fonts/font", dynamic_font)
	label.set("custom_colors/font_color", label_colour)
	label.set_uppercase(true)
	#label.autowrap = true
	var mc = MarginContainer.new()
	mc.set("custom_constants/margin_left", calc_margin_x(label_text))
	mc.add_child(label)
	return mc
	
	
func make_margin_container_label(params: Dictionary) -> MarginContainer:
	
	var label = Label.new()
	label.set_text(params.label_text)
	label.set("custom_fonts/font", dynamic_font)
	label.set("custom_colors/font_color", params.label_colour)
	label.set_uppercase(true)
	var mc = MarginContainer.new()
	
	# if we want center then this is needed
	mc.set("custom_constants/margin_left", calc_margin_x(params.label_text))
	
	if params.has("margin_top"):
		mc.set("custom_constants/margin_top", params.margin_top * 8)
	if params.has("margin_bottom"):
		mc.set("custom_constants/margin_bottom", params.margin_bottom * 8)
	
	mc.add_child(label)
	return mc	


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
