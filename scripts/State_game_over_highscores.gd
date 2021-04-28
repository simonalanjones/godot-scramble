#
# This is a holding node while post-game highscores display
#

extends Node

var display_highscores: Reference
var reset_score_board: Reference

onready var fsm: StateMachine
onready var UI_wait_timer =  get_node("/root/Scramble/Game/UI_wait_timer")

func enter() -> void:
	
	UI_wait_timer.start({
		'accept_input': [],
		'wait_time': 10	
	})
		
	yield(UI_wait_timer, "waiting_expired")
	reset_score_board.call_func()
	exit("State_intro")

	
func exit(next_state):
	fsm.change_to(next_state)
