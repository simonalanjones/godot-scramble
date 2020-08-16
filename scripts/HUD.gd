extends CanvasLayer
signal lives_depleted

onready var lives:int = 3

func _ready():
	show_lives()
	$Player_one_label.visible = false
	$Game_over_label.visible = false
	

func show_lives()->void:
	match lives:
		0,1:
			$Lower_hud/ship_1.visible = false
			$Lower_hud/ship_2.visible = false
			$Lower_hud/ship_3.visible = false
		2:
			$Lower_hud/ship_1.visible = true
			$Lower_hud/ship_2.visible = false
			$Lower_hud/ship_3.visible = false
		3:
			$Lower_hud/ship_1.visible = true
			$Lower_hud/ship_2.visible = true
			$Lower_hud/ship_3.visible = false			
		4:
			$Lower_hud/ship_1.visible = true
			$Lower_hud/ship_2.visible = true
			$Lower_hud/ship_3.visible = true
	

func lose_life()->void:
	lives -= 1
	show_lives()
	if lives < 0:
		emit_signal("lives_depleted")
		
			
func extra_life()->void:
	lives += 1
	show_lives()
	
func switch_on_mission_complete():
	hide_stage_board()
	$Player_one_label.visible = false
	$Game_over_label.visible = false
	$Highscore_board.display_off()
	$Congrations_screen.visible = true
	

func switch_off_mission_complete():
	show_stage_board()
	$Lower_hud/Flag_holder.flag_earned()
	$Player_one_label.visible = false
	$Game_over_label.visible = false
	$Highscore_board.display_off()
	$Congrations_screen.visible = false
	
	
func switch_to_game_over():
	hide_stage_board()
	$Player_one_label.visible = true
	$Game_over_label.visible = true
	#$Score_board.disable_1up_blink()

func switch_to_high_scores():
	$Player_one_label.visible = false
	$Game_over_label.visible = false
	$Lower_hud.visible = false
	$Highscore_board.display_on()
	
	
func hide_stage_board():
	$Stage_board.visible = false
	
	
func show_stage_board():
	$Stage_board.visible = true
