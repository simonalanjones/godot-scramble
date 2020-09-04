extends CanvasLayer

signal lives_depleted

onready var lives:int = 3
onready var hud_ship_life:PackedScene = preload("res://scenes/Life.tscn")

func _ready() -> void:
	draw_ships(lives)
	$Player_one_label.visible = false
	$Game_over_label.visible = false
	
	
func draw_ships(amount: int):
	for n in get_node("Lower_hud/Lives").get_children():
		n.queue_free()
	
	if amount > 0:
		var xpos = 0
		var ypos = 248
		for _r in range(1, amount+1):
			var ship = hud_ship_life.instance()
			ship.global_position = Vector2(xpos,ypos)
			get_node("Lower_hud/Lives").add_child(ship)
			xpos += 16	


func show_lives() -> void:
	draw_ships(lives-1)
	

func lose_life() -> void:
	lives -= 1
	show_lives()
	if lives < 1:
		emit_signal("lives_depleted")
		
			
func extra_life() -> void:
	lives += 1
	show_lives()
	
func switch_on_mission_complete() -> void:
	hide_stage_board()
	$Player_one_label.visible = false
	$Game_over_label.visible = false
	$Highscore_board.display_off()
	$Congrations_screen.visible = true
	

func switch_off_mission_complete() -> void:
	show_stage_board()
	$Lower_hud/Flag_holder.flag_earned()
	$Player_one_label.visible = false
	$Game_over_label.visible = false
	$Highscore_board.display_off()
	$Congrations_screen.visible = false
	
	
func switch_to_game_over() -> void:
	hide_stage_board()
	$Player_one_label.visible = true
	$Game_over_label.visible = true
	#$Score_board.disable_1up_blink()

func switch_to_high_scores() -> void:
	$Player_one_label.visible = false
	$Game_over_label.visible = false
	$Lower_hud.visible = false
	$Highscore_board.display_on()
	
	
func hide_stage_board() -> void:
	$Stage_board.visible = false
	
	
func show_stage_board() -> void:
	$Stage_board.visible = true
