extends Node2D

onready var xpos = 221
onready var ypos = 252
onready var Flag_scene = preload("res://scenes/Flag.tscn")
onready var missions_completed = 0

func _ready():
	flag_earned()
	
	
func reset():
	xpos = 221
	ypos = 252
	
	
# comes as signal after completing mission	
func flag_earned():
	missions_completed+=1
	# limit the number of flags shown
	if missions_completed <= 16:
		var flag = Flag_scene.instance()
		flag.position = Vector2(xpos,ypos)
		add_child(flag)
		xpos -= 8 #update xposition for next flag
	else:
		for _c in get_children():
			_c.queue_free()
		xpos = 221
		missions_completed = 0
		flag_earned()
