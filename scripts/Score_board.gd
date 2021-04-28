extends CanvasLayer


signal extra_life_awarded

const SCORE_FOR_EXTRA_LIFE = 10000

var score: int
var extra_life: bool # flag to hold score threshold reached
var blink_1up: bool
var high_score: int  # highest score from highscore table

var submit_highscore_property: Reference
var demo_mode_check: Reference

# callback after highscores script has loaded. Highest score sent through signal
#func highscores_loaded(highest_score: int) -> void:

func init():
	score = 0
	extra_life = false
	blink_1up = true
	high_score = 0
	
func _ready():
	hide()
		
func highscores_loaded(scores: Array) -> void:
	$label_value_high_score.set_text(str(scores.max()))
	high_score = scores.max()
	
	
func reset() -> void:
	score = 0
	$label_value_score.set_text(str(score))
	extra_life = false
	

func submit_highscore() -> void:
	# submit score to highscore manager
	submit_highscore_property.call_func(score)


#func add_score(amount: int, projectile: KinematicBody2D) -> void:
func add_score(points: int) -> void:
	if demo_mode_check.call_func() == false:
		score += points
		if score >= SCORE_FOR_EXTRA_LIFE and extra_life == false:
			extra_life = true
			emit_signal('extra_life_awarded')
		$label_value_score.set_text(str(score))
		if score > high_score:
			high_score = score
			$label_value_high_score.set_text(str(high_score))

	
func enable_1up_blink() -> void:
	blink_1up = true
	
	
func disable_1up_blink() -> void:
	get_node("label_text_1up").visible = true
	blink_1up = false
	
		
func _on_Timer_timeout() -> void:
	if blink_1up == true:
		$label_text_1up.visible = !$label_text_1up.visible


func hide() -> void:
	for child in get_children():
		if child is Label:
			child.visible = false
			
func show() -> void:
	for child in get_children():
		if child is Label:
			child.visible = true
