extends Node2D

func _ready():
	#display_off()
	pass

func display_on():
	for _n in get_children():
		_n.visible = true
		

func display_off():
		for _n in get_children():
			_n.visible = false
