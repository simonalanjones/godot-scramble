extends Node

onready var Highscore_board = get_node("/root/Scramble/UI/UI_screens/Highscore_board")

func enter():
	Highscore_board.visible = true
	
	
func exit():
	Highscore_board.visible = false
