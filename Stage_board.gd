extends Node2D

func _ready():
	set_stage1()

func set_stage1():
	$Sprite/Section1.visible = true
	$Sprite/Section2.visible = false
	$Sprite/Section3.visible = false	
	$Sprite/Section4.visible = false
	$Sprite/Section5.visible = false
	$Sprite/Section6.visible = false
	
func set_stage2():
	$Sprite/Section2.visible = true

func set_stage3():
	$Sprite/Section3.visible = true	

func set_stage4():
	$Sprite/Section4.visible = true	

func set_stage5():
	$Sprite/Section5.visible = true	

func set_stage6():
	$Sprite/Section6.visible = true