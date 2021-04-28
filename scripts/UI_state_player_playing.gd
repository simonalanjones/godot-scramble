extends Node


var fsm: UI_state_machine

#onready var ui_score_board = get_node("/root/Scramble/UI/Score_board")
#onready var Game_over = get_node("/root/Scramble/UI/Game_over")
#onready var Score_table = get_node("/root/Scramble/UI/Score_table")
#onready var Animation_player = get_node("/root/Scramble/UI/Score_table/AnimationPlayer")
#onready var Highscore_board = get_node("/root/Scramble/UI/Highscore_board")
#onready var Intro = get_node("/root/Scramble/UI/Intro")
#onready var Mission_complete = get_node("/root/Scramble/UI/Mission_complete")

func enter():
	
	# inject references to functions into this like 
	#get_node("/root/Scramble/UI/Lower_hud").show()
	get_node("/root/Scramble/UI/Lower_hud").switch_to_player_mode()
	get_node("/root/Scramble/UI/Stage_board").show()
	
	#Intro.visible = false
	#Score_table.visible = false
	#Game_over.visible = false
	#Highscore_board.visible = false
	#Mission_complete.visible = false

	
func exit():
	pass
	#fsm.change_to(next_state)
