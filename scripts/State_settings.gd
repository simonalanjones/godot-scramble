# This state is entered into when the settings selected

extends Node

var fsm: StateMachine
var is_active


func enter() -> void:
	pass
		
	
func _on_selected_option(option: int) -> void:
	if option == 0:
		exit("State_key_controls")
	if option == 1: # view achievements
		exit("State_achievements")	
	if option == 2:  # return to game option
		exit("State_intro")
	
	
func exit(next_state):
	fsm.change_to(next_state)
	
