extends Node

signal demo_did_end

onready var fsm: StateMachine
onready var Wipe = get_node("/root/Scramble/Game/Wipe")

func enter() -> void:
	VisualServer.set_default_clear_color("000000")
	Wipe.play()
	yield(Wipe, "wipe_complete")
	emit_signal("demo_did_end")
	exit("State_intro")
	
func exit(next_state) -> void:
	fsm.change_to(next_state)
