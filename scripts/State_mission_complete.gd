# This state is entered into when the base has been destroyed

extends Node

var fsm: StateMachine

var flag_earned: Reference
var extra_life: Reference

onready var UI_wait_timer =  get_node("/root/Scramble/Game/UI_wait_timer")

func enter() -> void:
	
	UI_wait_timer.start({
		'accept_input': [],
		'wait_time': 3	
	})
		
	yield(UI_wait_timer, "waiting_expired")
	flag_earned.call_func()
	extra_life.call_func()
	fsm.mission_complete = false
	fsm.base_destroyed = false
	exit("State_playing")
	
	
func exit(next_state):
	fsm.change_to(next_state)
