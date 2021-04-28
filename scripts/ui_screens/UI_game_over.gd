extends "res://scripts/ui_screens/UI_view.gd"
tool

const GAME_OVER_TEXT = "GAME OVER"
const FONT_COLOUR = "ffffff"

func _ready():
	var mc = make_container_label(GAME_OVER_TEXT, FONT_COLOUR)
	mc.set("custom_constants/margin_top", 128)
	add_to_body(mc)
	render()
	
