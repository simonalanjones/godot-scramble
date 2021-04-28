extends Node

var fsm: StateMachine

# inject later
onready var UI_wait_timer =  get_node("/root/Scramble/Game/UI_wait_timer")

func enter():	
		
	UI_wait_timer.start({
		'accept_input': [ "ui_cancel", "ui_space" ],
		'wait_time': 2	
	})
		
	var key_pressed = yield(UI_wait_timer, "waiting_expired")
	if key_pressed == "ui_cancel":
		exit("State_player_starts")
	else:
		exit("State_demo_playing")
		

func exit(next_state) -> void:
	fsm.change_to(next_state)
