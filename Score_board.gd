extends Node2D

onready var score = 0

func _ready():
	add_score(0)

func add_score(amount):
	score+=amount
	var sc_text = "%05d" %score
	$label_value_score.text = str(sc_text)

func _on_Timer_timeout():
	$label_text_1up.visible = !$label_text_1up.visible