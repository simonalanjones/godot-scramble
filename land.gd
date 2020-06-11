extends Node2D
#8,16,24,32,40,48,56,64,72,80,88,96,104,112,120,128,136,144,152,160,168,176,184,192,200,208,216,224,232,240,248,256,264,272,280,288,296,304,312,320,328,336,344,352,360,368,376,384,392

onready var fill_landscape = preload("res://landscape_fill.tscn")
onready var flat_top = preload("res://flat_top.tscn")
onready var landscape_item = preload("res://landscape_item.tscn")

var screen_height
var columns = [10,10,11,12,13,14,14,15,16,16,17,18,19,20,19,20,19,18,17,16,16,15,16,15,15,16,15,15,15]
var column_pointer = 0
var last_y


func _ready():
	last_y = columns[0]
	var start_x = 0
	var start_y = 64
	var x_loop = 10
	
	screen_height = get_viewport().size.y
	
	for _x in range (columns.size()):
		
		var landscape_instance = landscape_item.instance()
		var fill_instance = fill_landscape.instance()
		
		var y_pos = columns[column_pointer]+8
		var y_pos_cap = columns[column_pointer]*8
		
		var next_y
		if _x < columns.size()-1:
			next_y = columns[column_pointer+1]*8
		else:
			next_y = 0
		
		var pos_cap_fill = Vector2(start_x,y_pos_cap)
		var pos_fill = Vector2(start_x,y_pos_cap+8)
		
		fill_instance.set_position(pos_fill)
		fill_instance.set_height(screen_height)
		
		landscape_instance.set_position(pos_cap_fill)
		var texture
	
		
		print(str(y_pos_cap) + ' - ' + str(last_y))
		
		if y_pos_cap > last_y and y_pos_cap > next_y:
			texture = 'top_cap_inverted.png' 
		
		# this column is greather Y (lower) than last one
		elif y_pos_cap > last_y:
			
			if next_y == y_pos_cap:
				texture = 'top_bumpy.png'
			elif next_y < y_pos_cap:
				texture = 'top_bumpy.png'
			else:
				texture = 'b2.png'
				
		# this column is lower Y (higher) than last one		
		elif y_pos_cap < last_y:
			if next_y > y_pos_cap:
				texture = 'top_cap.png'	
			
			else:
				texture = 'b6.png'
			
		# this column is same Y (flat) as last one
		else:
			if next_y > y_pos_cap:
				texture = 'b2.png'
			else:
				texture = 'top_bumpy.png'
			
		landscape_instance.set_texture(texture)
		
		add_child(landscape_instance)
		add_child(fill_instance)
		start_x +=9
		column_pointer+=1
		last_y = y_pos_cap
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
