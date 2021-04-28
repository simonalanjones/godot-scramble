extends Node2D

#signal ui_intro_complete
#signal ui_game_over_complete
#signal ui_mission_comp_complete
#signal ui_highscores_complete

const HIGH_SCORE_SCREEN_WAIT = 4
const MISSION_COMPLETE_SCREEN_WAIT = 4
const SCORE_TABLE_SCREEN_WAIT = 2
const GAME_OVER_SCREEN_WAIT = 3
const INTRO_SCREEN_WAIT = 2

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


onready var Game_over = get_node("Game_over")
onready var Score_table = get_node("Score_table")
onready var Animation_player = get_node("Score_table/AnimationPlayer")
onready var Highscore_board = get_node("Highscore_board")
onready var Intro = get_node("Intro")
onready var Mission_complete = get_node("Mission_complete")

onready var Wipe = get_node("/root/Scramble/UI/Wipe")
#onready var UI_timer = get_node("/root/Scramble/UI/UI_timer")

onready var ui_stageboard = get_node("Stage_board")
onready var ui_score_board = get_node("Score_board")
onready var ui_lower_hud = get_node("Lower_hud")




func _ready():
	pass
	#$Score_table/score_items/fuel.get_material().set_shader_param("stand", PINK)
	#$Score_table/score_items/fuel.get_material().set_shader_param("ul_chars", RED)	
	#$Score_table/score_items/fuel.get_material().set_shader_param("tank", GREEN)
	
	#$Score_table/score_items/rocket1.get_material().set_shader_param("fill", RED)
	#$Score_table/score_items/rocket1.get_material().set_shader_param("outline", BLUE_HAZE)
	#$Score_table/score_items/rocket1.get_material().set_shader_param("thrust", PINK)
	
	#$Score_table/score_items/rocket_frame2.get_material().set_shader_param("fill", RED)
	#$Score_table/score_items/rocket_frame2.get_material().set_shader_param("outline", BLUE_HAZE)
	#$Score_table/score_items/rocket_frame2.get_material().set_shader_param("thrust", PINK)
	
	#$Score_table/score_items/mystery.get_material().set_shader_param("right", colours.red)
	#$Score_table/score_items/mystery.get_material().set_shader_param("left", colours.yellow)	
	#$Score_table/score_items/mystery.get_material().set_shader_param("middle", colours.dark_blue)

	#$Score_table/score_items/base.get_material().set_shader_param("left", colours.yellow)
	#$Score_table/score_items/base.get_material().set_shader_param("right", colours.green)
	#$Score_table/score_items/base.get_material().set_shader_param("middle", colours.pink)

	#ui_timer = Timer.new()
	#add_child(ui_timer)
	#switch_to_intro()

	
	
func hide():
	visible = false
	
func show():
	visible = true	


func _switch_to_playing():
	hide()
	ui_stageboard.show()
	ui_lower_hud.show()
	#Intro.visible = false
	#Score_table.visible = false
	#Game_over.visible = false
	#Highscore_board.visible = false
	
func _switch_to_player_playing() -> void:
	hide() # hide all text screens, leaving just the canvas items
	ui_stageboard.show()
	ui_lower_hud.switch_to_player_mode()
	
	
func _switch_to_demo_playing() -> void:
	hide() # hide all text screens, leaving just the canvas items
	ui_stageboard.show()
	ui_lower_hud.switch_to_demo_mode()
	
	
func _switch_to_highscores() -> void:
	_show_highscores()
	
	#ui_timer.set_wait_time(HIGH_SCORE_SCREEN_WAIT)
	#ui_timer.start()
	#yield(ui_timer, "timeout")
	emit_signal("ui_highscores_complete")
		

func _switch_to_game_over():
	show()
	ui_stageboard.hide()
	_show_game_over()
	#ui_timer.set_wait_time(GAME_OVER_SCREEN_WAIT)
	#ui_timer.start()
	#yield(ui_timer, "timeout")
	emit_signal("ui_game_over_complete")


# on_ui_cancelled ? general
func on_intro_cancelled():
	pass

func _switch_to_intro():
	
	show()
	ui_stageboard.hide()
	ui_lower_hud.hide()
	
	_show_intro()
	$UI_wait_timer.start({#'accept_input': [ "ui_right", "ui_left" ],
		'wait_time': 5	
	})
		
	var _key = yield($UI_wait_timer, "waiting_expired")
	#if key == "ui_right":
	#	emit_signal("start_game_requested")
	#else:
	#	exit("ui_high_scores")	
	
		
	print("waiting expired")
	
	_show_highscores()
	$UI_wait_timer.start({'wait_time': 5})
	yield($UI_wait_timer, "waiting_expired")
	
	_show_score_table()	
	Animation_player.play("points")
	#yield(Animation_player, "animation_finished")

	
	
	
	
	
func __switch_to_intro():
	show()
	ui_stageboard.hide()
	ui_lower_hud.hide()
	
	_show_intro()
	
	#UI_timer.start([KEY_A], INTRO_SCREEN_WAIT)
	#yield(UI_timer, "wait_over")
	#print('---')
	#print('wait over - yield')
	#ui_timer.set_wait_time(INTRO_SCREEN_WAIT)
	#ui_timer.start()
	#yield(ui_timer, "timeout")
	
	_show_score_table()	
	Animation_player.play("points")
	yield(Animation_player, "animation_finished")
	print ('ani finished')
	
	
	#ui_timer.set_wait_time(SCORE_TABLE_SCREEN_WAIT)
	#ui_timer.start()
	#yield(ui_timer, "timeout")
	Intro.visible = false
	
#	show_highscores()
	#ui_timer.set_wait_time(HIGH_SCORE_SCREEN_WAIT)
	#ui_timer.start()
	#yield(ui_timer, "timeout")
#	Wipe.play()
#	yield(Wipe, "wipe_complete")
	
#	emit_signal("ui_intro_complete")
	
	
	
func _switch_to_mission_complete():
	print('in ui mission comp')
	show()
	VisualServer.set_default_clear_color("000000")
	_show_mission_complete()
	#Mission_complete.visible = true
	#Intro.visible = false
	#Score_table.visible = false
	#Game_over.visible = false
	#Highscore_board.visible = false
	#ui_timer.set_wait_time(MISSION_COMPLETE_SCREEN_WAIT)
	#ui_timer.start()
	#yield(ui_timer, "timeout")
	Mission_complete.visible = false
	emit_signal("ui_mission_comp_complete")
	

func _show_intro():
	Intro.visible = true
	Score_table.visible = false
	Game_over.visible = false
	Highscore_board.visible = false
	Mission_complete.visible = false


func _show_score_table():
	Intro.visible = false
	Game_over.visible = false
	Highscore_board.visible = false
	Mission_complete.visible = false
	Score_table.visible = true
	Score_table.reset()	
	
	
func _show_game_over():
	Intro.visible = false
	Score_table.visible = false
	Game_over.visible = true
	Highscore_board.visible = false
	Mission_complete.visible = false
	
	
func _show_highscores():
	Intro.visible = false
	Score_table.visible = false
	Game_over.visible = false
	Highscore_board.visible = true
	Mission_complete.visible = false
	
	
func _show_mission_complete():
	Intro.visible = false
	Score_table.visible = false
	Game_over.visible = false
	Highscore_board.visible = false
	Mission_complete.visible = true
