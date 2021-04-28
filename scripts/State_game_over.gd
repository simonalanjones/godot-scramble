#
# This is a holding node while game over text displays waiting for ui callback
#
extends Node

onready var fsm: StateMachine
onready var UI_wait_timer =  get_node("/root/Scramble/Game/UI_wait_timer")

func enter() -> void:
	VisualServer.set_default_clear_color("000000")
	
	UI_wait_timer.start({
		'accept_input': [],
		'wait_time': 2	
	})
		
	yield(UI_wait_timer, "waiting_expired")
	exit("State_game_over_high_scores")

func exit(next_state) -> void:
	fsm.change_to(next_state)
