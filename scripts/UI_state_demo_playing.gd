extends Node

func enter():
	
	# inject references to functions into this like 
	get_node("/root/Scramble/UI/Stage_board").show()
	get_node("/root/Scramble/UI/Lower_hud").switch_to_demo_mode()
	
	
func exit():
	get_node("/root/Scramble/UI/Stage_board").hide()
	get_node("/root/Scramble/UI/Lower_hud").switch_off()
