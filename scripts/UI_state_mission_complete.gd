extends Node

onready var Mission_complete = get_node("/root/Scramble/UI/UI_screens/Mission_complete")

func enter():
	Mission_complete.visible = true
	
	
func exit():
	Mission_complete.visible = false
