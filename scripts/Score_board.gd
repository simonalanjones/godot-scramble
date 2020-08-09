extends Node2D

signal extra_life_awarded

onready var score:int = 0
onready var extra_life:bool = false

func _ready():
	add_score(0)

func add_score(amount):
	score += amount
	if score >= 10000 and extra_life == false:
		emit_signal('extra_life_awarded')
	var sc_text = "%05d" %score
	$label_value_score.text = str(sc_text)

func _on_Timer_timeout():
	$label_text_1up.visible = !$label_text_1up.visible
