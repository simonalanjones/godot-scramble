extends Node

onready var Highscore_board = get_node("/root/Scramble/UI/UI_screens/Highscore_board")
onready var UI_lower_hud = get_node("/root/Scramble/UI/Lower_hud")


func enter():
	Highscore_board.visible = true
	
	
func exit():
	Highscore_board.visible = false
	UI_lower_hud.switch_off()
	
