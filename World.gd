extends Node

onready var Rocket_container_node = get_node("/root/World/Rocket_container")
onready var Fuel_container_node = get_node("/root/World/Fuel_container")
onready var Mystery_container_node = get_node("/root/World/Mystery_container")
onready var Ufo_container_node = get_node("/root/World/Ufo_container")
onready var Colour_timer_node = get_node("/root/World/Colour_timer")
onready var Tilemap_node = get_node("/root/World/Landscape")
onready var Section2_node = get_node("/root/World/Section2")
onready var Section3_node = get_node("/root/World/Section3")
onready var Section4_node = get_node("/root/World/Section4")
onready var Stage_board_node = get_node("/root/World/HUD/Stage_board")
onready var Score_board_node = get_node("/root/World/HUD/Score_board")
onready var Fuel_bar_node = get_node("/root/World/HUD/Fuel_bar")

func _ready():
	Colour_timer_node.connect('timeout', Tilemap_node, 'change_colour')
	Tilemap_node.connect('colours_did_change',Rocket_container_node,'change_colour')
	Tilemap_node.connect('colours_did_change',Fuel_container_node,'change_colour')	
	Tilemap_node.connect('colours_did_change',Mystery_container_node,'change_colour')
	
	Section2_node.connect('screen_entered',self,'section2_start')
	Section3_node.connect('screen_entered',self,'section3_start')
	Section4_node.connect('screen_entered',self,'section4_start')
	Fuel_container_node.connect('fuel_was_hit',self, 'fuel_bonus')
	Rocket_container_node.connect('rocket_was_hit',self, 'rocket_bonus')
	Mystery_container_node.connect('mystery_was_hit',self, 'mystery_bonus')
	
func rocket_bonus(points):
	Score_board_node.add_score(points)

func fuel_bonus(points):
	Fuel_bar_node.restore(10)
	Score_board_node.add_score(points)

func mystery_bonus(points):
	Score_board_node.add_score(points)
	
func section2_start():
	# start the timer before moving ufos?
	# at end have timer to stop spawning more
	print('hello we are in section2')
	
	Stage_board_node.set_stage2()
	Ufo_container_node.enable()

func section3_start():
	pass

func section4_start():	
	pass

	
func _on_Area2D_area_entered(_area):
	print('hit the left edge')


func _on_Area2D_area_exited(_area):
	print('left the left edge')
