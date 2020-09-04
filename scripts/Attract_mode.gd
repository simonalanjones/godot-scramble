extends Node2D

signal fire_pressed

const GREEN = Color(0.11,0.76,0)
const PURPLE = Color(0.52,0,0.85)
const RED = Color(0.87,0,0)
const LIGHT_BLUE = Color(0,0.76,0.85)
const DARK_BLUE = Color(0,0,0.85)
const YELLOW = Color(0.87,0.87,0)
const PINK = Color(0.88,0,0.85)
const BLUE_HAZE = Color(0.76,0.76,0.85)
const SILVER = Color(0.75,0.75,0.75)
const GREY = Color(0.5,0.5,0.5)
const DARK_GREY = Color(0.25,0.25,0.25)
const BLACK = Color(0,0,0)
const WHITE = Color(1,1,1)


onready var viewport:Viewport = get_viewport()
onready var Score_board = get_node("/root/Attract_mode/Score_board")
onready var Score_table = get_node("/root/Attract_mode/Score_table")
onready var Animation_player = get_node("/root/Attract_mode/Score_table/AnimationPlayer")
onready var Highscore_board = get_node("/root/Attract_mode/Highscore_board")
onready var Intro = get_node("/root/Attract_mode/Intro")

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
	
func _ready() -> void:
	Intro.visible = false
	Score_table.visible = false
	Highscore_board.visible = false
	
		
	var _a = get_tree().connect("screen_resized", self, "_screen_resized")
	_screen_resized()
	
	Score_board.highscore_property = funcref(Highscore_board, "get_highscore")
	Score_board.submit_highscore_property = funcref(Highscore_board, "submit_score")
	Highscore_board.connect('highscores_loaded', self, 'highscores_loaded')
	Score_board.disable_1up_blink()
	
	$Score_table/score_items/fuel.get_material().set_shader_param("stand", PINK)
	$Score_table/score_items/fuel.get_material().set_shader_param("ul_chars", RED)	
	$Score_table/score_items/fuel.get_material().set_shader_param("tank", GREEN)
	
	$Score_table/score_items/rocket1.get_material().set_shader_param("fill", RED)
	$Score_table/score_items/rocket1.get_material().set_shader_param("outline", BLUE_HAZE)
	$Score_table/score_items/rocket1.get_material().set_shader_param("thrust", PINK)
	
	$Score_table/score_items/rocket_frame2.get_material().set_shader_param("fill", RED)
	$Score_table/score_items/rocket_frame2.get_material().set_shader_param("outline", BLUE_HAZE)
	$Score_table/score_items/rocket_frame2.get_material().set_shader_param("thrust", PINK)
	
	$Score_table/score_items/mystery.get_material().set_shader_param("right", colours.red)
	$Score_table/score_items/mystery.get_material().set_shader_param("left", colours.yellow)	
	$Score_table/score_items/mystery.get_material().set_shader_param("middle", colours.dark_blue)

	$Score_table/score_items/base.get_material().set_shader_param("left", colours.yellow)
	$Score_table/score_items/base.get_material().set_shader_param("right", colours.green)
	$Score_table/score_items/base.get_material().set_shader_param("middle", colours.pink)


func highscores_loaded() -> void:
	while true:		
		Intro.visible = true
		yield(get_tree().create_timer(2), "timeout")
		Intro.visible = false
		Highscore_board.visible = true
		yield(get_tree().create_timer(4), "timeout")
		Highscore_board.visible = false
		Score_table.visible = true
		yield(get_tree().create_timer(.5), "timeout")
		Animation_player.play("points")
		yield(get_tree().create_timer(12), "timeout")
		Score_table.visible = false
		Score_table.reset()
	
func _input(event) -> void:
	if event.is_action_pressed("ui_accept"):
		emit_signal("fire_pressed")
		start_game()
		#$"Background/AnimationPlayer".play("wipe")
		#get_ready_text.visible = true
		yield(get_tree().create_timer(.5),"timeout") #small delay for wipe transition
		#Scene_switcher.change_scene("res://scenes/Main.tscn", {"demo_mode":false})
		
func start_game() -> void:
	yield(get_tree().create_timer(1),"timeout")
	if not get_tree().change_scene("res://scenes/TileMap.tscn") == 0:
		print('error loading main scene')
