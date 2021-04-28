# This pseudo-state machine receives signals from Game state machine
# defined in Game.gd so game and UI screens are in sync

extends Node

class_name UI_state_machine

const DEBUG = false

var state: Object
var previous_state: Object

var turn_on_stars: Reference
var turn_off_stars: Reference

onready var Game_over = get_node("/root/Scramble/UI/UI_screens/Game_over")
onready var Score_table = get_node("/root/Scramble/UI/UI_screens/Score_table")
onready var Highscore_board = get_node("/root/Scramble/UI/UI_screens/Highscore_board")
onready var Intro = get_node("/root/Scramble/UI/UI_screens/Intro")
onready var Mission_complete = get_node("/root/Scramble/UI/UI_screens/Mission_complete")
onready var Player_starting = get_node("/root/Scramble/UI/UI_screens/Player_starting")
onready var Settings = get_node("/root/Scramble/UI/UI_screens/Settings")

func _ready() -> void:

	state = get_child(0)	
	yield(get_tree().create_timer(.3), "timeout") # allow all to load in
	
	get_node("/root/Scramble/UI/Stage_board").hide()
	get_node("/root/Scramble/UI/Lower_hud").switch_off()
	
	Intro.visible = false
	Player_starting.visible = false
	Score_table.visible = false
	Game_over.visible = false
	Highscore_board.visible = false
	Mission_complete.visible = false
	
	
func get_state_name() -> String:
	return state.name


func change_to_achievements() -> void:
	_change_to("UI_state_achievements")
	
	
func change_to_settings() -> void:
	turn_off_stars.call_func()
	_change_to("UI_state_settings")		


func change_to_intro() -> void:
	turn_on_stars.call_func()
	_change_to("UI_state_intro")


func change_to_key_controls() -> void:
	VisualServer.set_default_clear_color("ff0000")
	_change_to("UI_state_key_controls")


func change_to_high_scores() -> void:
	_change_to("UI_state_high_scores")	


func change_to_score_table() -> void:
	_change_to("UI_state_score_table")	


func change_to_demo_playing() -> void:
	_change_to("UI_state_demo_playing")		
	
	
func change_to_player_starts() -> void:
	_change_to("UI_state_player_starts")
	
	
func change_to_player_playing() -> void:
	_change_to("UI_state_player_playing")	
	
	
func change_to_game_over() -> void:
	_change_to("UI_state_game_over")	


func change_to_game_over_high_scores() -> void:
	_change_to("UI_state_game_over_high_scores")	
	

func change_to_mission_complete() -> void:
	_change_to("UI_state_mission_complete")
	
	
func _change_to(new_state) -> void:
	previous_state = state
	state = get_node(new_state)
	_enter_state()


func _enter_state() -> void:
	if DEBUG:
		print("Entering state: ", state.name)
		if state.name != previous_state.name:
			print("Exiting state: ", previous_state.name)

	if state.name != previous_state.name:
		if previous_state.has_method("exit"):
			previous_state.exit()
			
	state.enter()
