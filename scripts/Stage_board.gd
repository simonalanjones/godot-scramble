extends Node2D

var stage_active:int  = 1

func _ready() -> void:
	set_stage1()

func get_active_stage() -> int:
	return stage_active

	
func set_stage1() -> void:
	stage_active = 1
	$Sprite/Section1.visible = true
	$Sprite/Section2.visible = false
	$Sprite/Section3.visible = false	
	$Sprite/Section4.visible = false
	$Sprite/Section5.visible = false
	$Sprite/Section6.visible = false
	
func set_stage2() -> void:
	stage_active = 2
	$Sprite/Section2.visible = true

func set_stage3() -> void:
	stage_active = 3
	$Sprite/Section3.visible = true	

func set_stage4() -> void:
	stage_active = 4
	$Sprite/Section4.visible = true	

func set_stage5() -> void:
	stage_active = 5
	$Sprite/Section5.visible = true	

func set_stage6() -> void:
	stage_active = 6
	$Sprite/Section6.visible = true
