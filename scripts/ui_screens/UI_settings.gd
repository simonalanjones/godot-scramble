extends "res://scripts/ui_screens/UI_view.gd"
tool

const HEADER_TEXT = "- SETTINGS -"
const FOOTER_TEXT = "PRESS %s TO START"


const COLOUR_HEADING = "e03d00"
const COLOUR_KEY_ACTIONS = "f5eb14"
const COLOUR_KEY_LABELS = "ffffff"

const MID_SECTION_MARGINS = 32
const MID_SECTION_LINE_SPACING = 8

var labels = [ "view key controls", "view achievements", "return to game" ]

var selected_option = 0
var containers: = []

func _ready() -> void:
	var mc = make_container_label(HEADER_TEXT, COLOUR_HEADING)
	mc.set("custom_constants/margin_top", 32)
	mc.set("custom_constants/margin_bottom", 32)
	add_to_head(mc)
	

	for label in labels:
		var body_mc = make_container_label(label, COLOUR_HEADING)
		#body_mc.set("custom_constants/margin_top", 32)
		body_mc.set("custom_constants/margin_bottom", 16)
		#body_mc.add_to_group("options")
		containers.append(body_mc)
		add_to_head(body_mc)
		
	render()
	

func update_labels() -> void:
	for option in containers:
		option.get_children()[0].set("custom_colors/font_color", COLOUR_KEY_ACTIONS)
	containers[selected_option].get_children()[0].set("custom_colors/font_color", COLOUR_HEADING)
	
	
func get_selected_option() -> int:
	return selected_option

	
func select_text_up() -> void:
	if selected_option > 0:
		selected_option -= 1
		update_labels()


func select_text_down() -> void:
	if selected_option < labels.size()-1:
		selected_option += 1
		update_labels()
				

func show():
	visible = true
	
	
func hide():
	print('hiding')
	visible = false
	
