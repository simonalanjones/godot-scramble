extends Node
signal mission_completed

# don't forget to use stretch mode 'viewport' and aspect 'ignore'
onready var viewport = get_viewport()
onready var is_scrolling:bool = false
onready var is_game_over:bool = false
onready var missions_completed = 0 # needed to instruct speed of fuel bar

# need signal to wire this flag up (shoot base)
#onready var is_mission_complete:bool = false

func _screen_resized():
	var window_size = OS.get_window_size()
	# see how big the window is compared to the viewport size
	# floor it so we only get round numbers (0, 1, 2, 3 ...)
	var scale_x = floor(window_size.x / viewport.size.x)
	var scale_y = floor(window_size.y / viewport.size.y)

	# use the smaller scale with 1x minimum scale
	var scale = max(1, min(scale_x, scale_y))

	# find the coordinate we will use to center the viewport inside the window
	var diff = window_size - (viewport.size * scale)
	var diffhalf = (diff * 0.5).floor()

	# attach the viewport to the rect we calculated
	viewport.set_attach_to_screen_rect(Rect2(diffhalf, viewport.size * scale))

onready var Containers = get_node("/root/World/Containers");
onready var Colour_manager = get_node("/root/World/Colour_manager")
onready var Rocket_container = get_node("/root/World/Containers/Rocket_container")
onready var Fuel_container = get_node("/root/World/Containers/Fuel_container")
onready var Mystery_container = get_node("/root/World/Containers/Mystery_container")
onready var Ufo_container = get_node("/root/World/Containers/Ufo_container")
onready var Fireball_container = get_node("/root/World/Containers/Fireball_container")
onready var Explosion_container = get_node("/root/World/Containers/Explosion_container")
onready var Base_container = get_node("/root/World/Containers/Base_container")

onready var Tilemap = get_node("/root/World/Tilemap")

onready var Land_manager = get_node("/root/World/Landscape_manager")

onready var Stage_board = get_node("/root/World/HUD/Stage_board")
onready var Score_board = get_node("/root/World/HUD/Score_board")
onready var Fuel_bar = get_node("/root/World/HUD/Lower_hud/Fuel_bar")
onready var HUD = get_node("/root/World/HUD")
onready var Ship = get_node("/root/World/Ship")
onready var camera = get_node("/root/World/Tilemap/Camera2D")
onready var Highscore_board = get_node("/root/World/HUD/Highscore_board")


func _ready()->void:	
	VisualServer.set_default_clear_color("000000") #background set to black
	Fuel_bar.missions_completed = missions_completed
	#Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	var _a = get_tree().connect("screen_resized", self, "_screen_resized")
	_screen_resized()
			
	Fuel_bar.connect("fuel_depleted", Ship, "fuel_has_depleted")
	HUD.connect("lives_depleted", self, "game_over")
	
	HUD.connect("lives_depleted", Colour_manager, "disable")
	HUD.connect("lives_depleted", Score_board, "submit_highscore")
	
	Score_board.connect("extra_life_awarded", HUD, "extra_life")
	
	Ship.connect("ship_was_hit", self, "ship_was_hit")
	Ship.connect("ship_was_hit", Fuel_bar, "stop") 
	Ship.connect("ship_was_hit", Colour_manager, "flash_colours")
	
	Ship.connect("crash_animation_complete", HUD, "lose_life")
	Ship.connect("crash_animation_complete", self, "stage_restart",[],1) # deferred
	
	Ship.connect("crash_animation_complete", Colour_manager, "clear_flash_colours")
	Ship.connect("second_timeout", Score_board, "add_score",[10])

	Land_manager.connect('landscape_decoded', Tilemap, 'setup')
	Land_manager.connect('landscape_decoded', Rocket_container, 'setup')
	Land_manager.connect('landscape_decoded', Fuel_container, 'setup')
	Land_manager.connect('landscape_decoded', Mystery_container, 'setup')
	Land_manager.connect('landscape_decoded', Base_container, 'setup')
		
	Colour_manager.connect("colours_did_change", Tilemap, "change_colours")
	Colour_manager.connect("colours_did_change", Rocket_container, "change_colours")
	Colour_manager.connect("colours_did_change", Fuel_container, "change_colours")
	Colour_manager.connect("colours_did_change", Mystery_container, "change_colours")
	Colour_manager.connect("colours_did_change", Explosion_container, "change_colours")
	Colour_manager.connect("colours_did_change", Base_container, "change_colours")
		
	Fuel_container.connect("fuel_was_hit", Score_board, "add_score")
	Fuel_container.connect("fuel_was_hit", Fuel_bar, "restore")
	Rocket_container.connect("rocket_was_hit", Score_board, "add_score") 
	Mystery_container.connect("mystery_was_hit",Score_board, "add_score")
	Base_container.connect("base_was_hit",Score_board, "add_score")
	
	Tilemap.connect("landscape_draw_completed", self, "begin")
	
	# add access to the camera position as a spawn location helper
	Ufo_container.camera_property = funcref(camera, "get_camera_position")
	# add access to the camera position as a spawn location helper
	Fireball_container.camera_property = funcref(camera, "get_camera_position")
	
	# add access to the highscore functions from within score board
	Score_board.highscore_property = funcref(Highscore_board, "get_highscore")
	Score_board.submit_highscore_property = funcref(Highscore_board, "submit_score")

	Land_manager.setup(1)
	

func begin()->void:
	is_scrolling = true


func ship_was_hit()->void:
	is_scrolling = false
	
	
func _process(_delta)->void:
	if is_scrolling == true:
		camera.position.x += 150


func mission_completed():
	
	is_scrolling = false
	Ship.disable()
	missions_completed += 1
	Tilemap.clear_landscape()
	HUD.switch_on_mission_complete()
	#print('cleared')
	camera.set_position(Vector2.ZERO)
	
	yield(get_tree().create_timer(1), "timeout")
	emit_signal('new_mission_started')
	HUD.switch_off_mission_complete() # will also add a flag
	
	
	Land_manager.restart(1)
	Stage_board.set_stage1()
	Ship.reset()
	
	#stage_restart()
	"""
	VisualServer.set_default_clear_color("000000") 
	Colour_manager.disable()
	Ship.visible = false
	is_scrolling = false
	Tilemap.clear_landscape()
	
	for container in Containers.get_children():
		for child in container.get_children():
			child.queue_free()
	yield(get_tree().create_timer(1), "timeout")
	
	
	HUD.switch_off_
	is_scrolling = true
	Fuel_bar.reset()
	Stage_board.set_stage1()
	Fuel_bar.start()
	Ship.reset()
	
	Land_manager.restart(1)
	"""
	
	
func game_over()->void:
	VisualServer.set_default_clear_color("000000")
	is_game_over = true
	
	Ship.visible = false
	# remove rockets/fuel/mysterys/ufos/base/fireballs/explosions
	for container in Containers.get_children():
		for child in container.get_children():
			child.queue_free()
			
	Tilemap.clear_landscape()
	HUD.switch_to_game_over()
	yield(get_tree().create_timer(2), "timeout")
	HUD.switch_to_high_scores()


func stage_restart()->void:
	if is_game_over == false:
		is_scrolling = true
		camera.set_position(Vector2.ZERO)
		Land_manager.restart(Stage_board.get_active_stage())
	
		Fuel_bar.reset()
		Fuel_bar.start()
		Ship.reset()
		
	
func stage1_end()->void:	
	Rocket_container.disable_rockets()
	Stage_board.set_stage2()
	Ufo_container.enable()
	
	
func stage2_end()->void:	
	Rocket_container.disable_rockets()
	Ufo_container.disable()
	Fireball_container.enable()
	Stage_board.set_stage3()
	
	
func stage3_end()->void:	
	Ufo_container.disable()
	Fireball_container.disable()
	Rocket_container.enable_rockets()
	Stage_board.set_stage4()
	
	
func stage4_end()->void:	
	Rocket_container.enable_rockets()
	Stage_board.set_stage5()
	
	
func stage5_end()->void:	
	Stage_board.set_stage6()


func stage6_end()->void:
	print('complete')
	mission_completed()
