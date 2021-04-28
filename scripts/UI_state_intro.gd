extends Node

onready var Intro = get_node("/root/Scramble/UI/UI_screens/Intro")
onready var Score_table = get_node("/root/Scramble/UI/UI_screens/Score_table")
onready var Game_over = get_node("/root/Scramble/UI/UI_screens/Game_over")
onready var Score_board = get_node("/root/Scramble/UI/Score_board")

func enter():
	yield(get_tree().create_timer(.3), "timeout") # allow everything to load in
	Intro.visible = true
	Score_table.visible = false
	Game_over.visible = false
	Score_board.show()

func exit():
	Intro.visible = false
