extends Node

onready var Player_starting = get_node("/root/Scramble/UI/UI_screens/Player_starting")
onready var UI_lower_hud = get_node("/root/Scramble/UI/Lower_hud")

func enter():
	get_node("/root/Scramble/UI/Lower_hud").switch_to_player_mode()
	get_node("/root/Scramble/UI/Stage_board").show()
	
	Player_starting.visible = true


func exit():
	Player_starting.visible = false
