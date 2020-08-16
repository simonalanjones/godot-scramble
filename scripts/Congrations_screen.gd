extends Node2D


func display_on():
	visible = true
	$Completed_duties_label.visible = true
	$Congratulations_label.visible = true
	$Good_luck_label.visible = true
	
	
func display_off():
	visible = false
	$Completed_duties_label.visible = false
	$Congratulations_label.visible = false
	$Good_luck_label.visible = false
