extends Node2D

#var screen_height

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#var screen_height = get_viewport().size.y
	

func set_height(screen_height):
	var y_pos = int(get_global_position().y)
	
	var h = screen_height - y_pos
	var i = h/8
	
	# divide 16 ?? 
	#print(i)
	var s = Vector2()
	s.x = 1
	s.y = i
	$Sprite.scale = s