extends Node

var fsm: UI_state_machine

#onready var fuel_node = get_node("/root/Scramble/UI/UI_screens/Score_table/score_items/fuel")
#onready var rocket1_node = get_node("/root/Scramble/UI/UI_screens/Score_table/score_items/rocket1")
#onready var rocket_frame2_node = get_node("/root/Scramble/UI/UI_screens/Score_table/score_items/rocket_frame2")
#onready var mystery_node = get_node("/root/Scramble/UI/UI_screens/Score_table/score_items/mystery")
#onready var base_node = get_node("/root/Scramble/UI/UI_screens/Score_table/score_items/base")

onready var Score_table = get_node("/root/Scramble/UI/UI_screens/Score_table")
#onready var Animation_player = get_node("/root/Scramble/UI/UI_screens/Score_table/AnimationPlayer")

func enter():
	
	"""
	fuel_node.get_material().set_shader_param("stand", colours.pink)
	fuel_node.get_material().set_shader_param("ul_chars", colours.red)	
	fuel_node.get_material().set_shader_param("tank", colours.green)
	
	rocket1_node.get_material().set_shader_param("fill", colours.red)
	rocket1_node.get_material().set_shader_param("outline", colours.blue_haze)
	rocket1_node.get_material().set_shader_param("thrust", colours.pink)
	
	rocket_frame2_node.get_material().set_shader_param("fill", colours.red)
	rocket_frame2_node.get_material().set_shader_param("outline", colours.blue_haze)
	rocket_frame2_node.get_material().set_shader_param("thrust", colours.pink)
	
	mystery_node.get_material().set_shader_param("right", colours.red)
	mystery_node.get_material().set_shader_param("left", colours.yellow)	
	mystery_node.get_material().set_shader_param("middle", colours.dark_blue)

	base_node.get_material().set_shader_param("left", colours.yellow)
	base_node.get_material().set_shader_param("right", colours.green)
	base_node.get_material().set_shader_param("middle", colours.pink)
	"""
	Score_table.visible = true
	Score_table.start()
	#Score_table.reset()
	#Animation_player.play("points")
	
func exit():
	pass
	Score_table.visible = false
	#Score_table.reset()
	
	
