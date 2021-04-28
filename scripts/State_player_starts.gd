# This state is fired between intro and player playing
# Used for setting up the game before main play loop

extends Node

var fsm: StateMachine

var clear_flags: Reference
var reset_stage_board: Reference
var reset_land_manager: Reference
var reset_score_board: Reference
var reset_lives: Reference
var flag_earned: Reference
var show_lives: Reference
var reset_fuel: Reference
var reset_bombs: Reference
var reset_bullets: Reference
var start_music: Reference
var reset_colours: Reference

onready var UI_wait_timer =  get_node("/root/Scramble/Game/UI_wait_timer")


func enter() -> void:
	fsm.clear_player_crashed()
	start_music.call_func()
	clear_flags.call_func()
	reset_stage_board.call_func()
	reset_land_manager.call_func()
	reset_score_board.call_func()
	reset_lives.call_func()
	flag_earned.call_func()
	reset_fuel.call_func()
	reset_bombs.call_func()
	reset_bullets.call_func()
	reset_colours.call_func()
	
	
	
	UI_wait_timer.start({
		'accept_input': [],
		'wait_time': 3	
	})
		
	yield(UI_wait_timer, "waiting_expired")
	show_lives.call_func()
	
	
	# need to pause and play a tune here?
	exit("State_playing")


func exit(next_state) -> void:
	fsm.change_to(next_state)
