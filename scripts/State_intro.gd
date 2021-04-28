extends Node

var fsm: StateMachine

var reset_camera: Reference
var turn_on_stars: Reference


onready var UI_wait_timer =  get_node("/root/Scramble/Game/UI_wait_timer")


func enter():
	reset_camera.call_func()
	turn_on_stars.call_func()
	
		
	UI_wait_timer.start({
		'accept_input': [ "ui_cancel", "ui_space", "start" ],
		'wait_time': 6	
	})
		
	var key_pressed = yield(UI_wait_timer, "waiting_expired")
	
	if key_pressed == "ui_cancel":
		exit("State_settings")
	elif key_pressed == "start":
		print('hit start')
		exit("State_player_starts")
	else:
		exit("State_score_table")
		
	
func exit(next_state) -> void:
	fsm.change_to(next_state)
