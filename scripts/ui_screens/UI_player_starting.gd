extends "res://scripts/ui_screens/UI_view.gd"
tool

const GET_READY_TEXT = "GET READY"

func _ready():
	var mc1 = make_container_label(GET_READY_TEXT, "ffffff")
	mc1.set("custom_constants/margin_top", 128)
	add_to_body(mc1)
	render()
