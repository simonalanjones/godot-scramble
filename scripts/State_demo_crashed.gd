# This node is a holding state while the demo crash animation plays
extends Node

var fsm: StateMachine

onready var UI_wait_timer =  get_node("/root/Scramble/Game/UI_wait_timer")


func enter() -> void:
		
	UI_wait_timer.start({
		'accept_input': [],
		'wait_time': 2	
	})
		
	yield(UI_wait_timer, "waiting_expired")
	exit("State_demo_over")
	
	
func exit(next_state) -> void:
	fsm.change_to(next_state)
