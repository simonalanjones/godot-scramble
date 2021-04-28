extends Node

var fsm: StateMachine


func _on_escape_key():
	exit("State_settings")
	
func enter():	
	pass		
		

func exit(next_state) -> void:
	fsm.change_to(next_state)
