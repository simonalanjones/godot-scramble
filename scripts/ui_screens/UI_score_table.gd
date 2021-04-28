extends "res://scripts/ui_screens/UI_view.gd"
tool

const SCORE_TABLE_TEXT = "- SCORE TABLE -"
const FONT_COLOUR = "ffff00"
const LABEL_COLOUR = "ffffff"
const TEXT_POINTS = [ 
		"50 PTS", "80 PTS", "100 PTS", "150 PTS", "800 PTS", "MYSTERY"
	]
const TEXT_DOTS = "..."
const FOOTER_TEXT_L1 = "BONUS JET  FOR 10000 PTS"
const FOOTER_TEXT_L2 = "[ESC] KEY: HELP"


var textures = {
	"rocket" : {
		"texture": preload("res://sprites/rocket/rocket_frame_shader.png"),
		"shader": {
			"material": preload("res://shaders/Rocket.shader"),
			"params": {
				"fill": colours.red,
				"outline": colours.blue_haze,
				"thrust": colours.pink
			}
		}
	},
	"rocket_flight": {
		"texture": preload("res://sprites/rocket/rocket_frame5_shader.png"),
		"shader": {
			"material": preload("res://shaders/Rocket.shader"),
			"params": {
				"fill": colours.red,
				"outline": colours.blue_haze,
				"thrust": colours.pink
			}
		}
	},
	"ufo": {
		"texture": preload("res://sprites/ufo.png"),
	},
	"fuel": {
		"texture": preload("res://sprites/fuel_dump_shader.png"),
		"shader": {
			"material": preload("res://shaders/Fuel_dump.shader"),
			"params": {
				"stand": colours.pink,
				"ul_chars": colours.red,
				"tank": colours.green
			}
		}
	},
	"base": {
		"texture": preload("res://sprites/base/base_frame1_shader.png"),
		"shader": {
			"material": preload("res://shaders/Mystery.shader"),
			"params": {
				"right": colours.green,
				"left": colours.yellow,
				"middle": colours.pink
			}
		}
	},
	"mystery": {
		"texture": preload("res://sprites/mystery_shader.png"),
		"shader": {
			"material": preload("res://shaders/Mystery.shader"),
			"params": {
				"right": colours.red,
				"left": colours.yellow,
				"middle": colours.dark_blue
			}
		}
	}
}

var sprites_array: = []
var label_array:= []
var row_counter: int
var tween: Tween
	

func _ready():
	
	tween = Tween.new()  
	add_child(tween)
	var _a = tween.connect("tween_completed", self, "tween_completed")
	
	for i in textures:
		var text_rect = TextureRect.new()
		text_rect.texture = textures[i].texture
		
		if textures[i].has("shader"):
			var material = ShaderMaterial.new()
			material.set_shader(textures[i].shader.material)
		
			for param in textures[i].shader.params.keys():
				material.set_shader_param(param, textures[i].shader.params[param])
			text_rect.set_material(material)
		sprites_array.append(text_rect)
		
		
	var mc = make_container_label(SCORE_TABLE_TEXT, FONT_COLOUR)
	mc.set("custom_constants/margin_top", 40)
	add_to_body(mc)
	
	var grid_container = GridContainer.new()
	grid_container.set_columns(3)
	grid_container.set("custom_constants/hseparation", 8)
	grid_container.set("custom_constants/vseparation", 12)

	for i in range (0,TEXT_POINTS.size()):
		var label_dots = make_label(TEXT_DOTS, LABEL_COLOUR)
		var label_points = make_label(TEXT_POINTS[i], LABEL_COLOUR)
		
		label_array.append(label_dots)
		label_array.append(label_points)
		
		grid_container.add_child(sprites_array[i])
		grid_container.add_child(label_dots)
		grid_container.add_child(label_points)
	
	var grid_mc = MarginContainer.new()
	grid_mc.set("custom_constants/margin_left", 60)
	grid_mc.set("custom_constants/margin_top", 12)
	grid_mc.add_child(grid_container)
	
	add_to_body(grid_mc)		
	render()
	
	
func start():
	# hide labels before running tweens
	for i in label_array.size():
		label_array[i].visible_characters = 0
	row_counter = 0
	do_animation()
		
	
func do_animation():
	var the_label = label_array[row_counter]
	var length = the_label.text.length()
	var duration = 0.1 * length # tween has speed consistent with text length
	var _t = tween.interpolate_property(the_label, "visible_characters", 0,length, duration,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	var _s = tween.start()
	
		
func tween_completed(_object,_key):
	if row_counter < label_array.size()-1:
		row_counter += 1
		do_animation()
