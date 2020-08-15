extends Node2D

signal extra_life_awarded

onready var score:int = 0
onready var extra_life:bool = false
onready var blink_1up:bool = true
onready var high_score:int # highest score from highscore table

onready var highscore_property
onready var submit_highscore_property

# SHOULD THE SCOREBOARD INCLUDE THE CODE FROM HIGHSCORE BOARD?


# get the highest score from highscore board
func get_high_score() -> int:
	if highscore_property.is_valid():
		return highscore_property.call_func()
	else:
		return 0
	
	
# submit player score to highscore board	
func submit_highscore() -> void:
	if submit_highscore_property.is_valid():
		submit_highscore_property.call_func(score)
	
	
func _ready():
	yield(get_tree(), "idle_frame")
	add_score(0)
	high_score = get_high_score()
	var high_score_text = "%05d" %high_score
	$label_value_high_score.set_text(str(high_score_text))
		
	
func setup(_high_score):
	high_score = _high_score
	
	
func add_score(amount):
	score += amount
	if score >= 10000 and extra_life == false:
		emit_signal('extra_life_awarded')
	var sc_text = "%05d" %score
	$label_value_score.text = str(sc_text)
	if score > high_score:
		high_score = score
		var high_score_text = "%05d" %high_score
		$label_value_high_score.set_text(str(high_score_text))
	
	
func enable_1up_blink():
	blink_1up = true
	
	
func disable_1up_blink():
	$label_text_1up.visible = visible
	blink_1up = false
	
		
func _on_Timer_timeout():
	if blink_1up == true:
		$label_text_1up.visible = !$label_text_1up.visible
