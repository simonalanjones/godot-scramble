extends Node

onready var Game_over = get_node("/root/Scramble/UI/UI_screens/Game_over")
onready var UI_stageboard = get_node("/root/Scramble/UI/Stage_board")


func enter():
	UI_stageboard.hide()
	Game_over.visible = true

	
func exit():
	Game_over.visible = false
