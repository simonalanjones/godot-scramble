extends Node

var fsm: StateMachine

func enter():
	yield(get_tree().create_timer(.3), "timeout") # allow everything to load in
	exit("State_intro")
	#exit("State_settings")

func exit(next_state):
	fsm.change_to(next_state)
