extends Node2D

# Maintains the number of missions completed and draws the flags

const MAX_FLAGS_DISPLAYED = 16
const FLAG_STARTING_X_POS = 221
const FLAG_STARTING_Y_POS = 252
const PIXELS_BETWEEN_FLAGS = 8

# reference to scene factory function
var create_flag:Reference

var xpos: int
var ypos: int

var missions_completed:int = 0 setget ,get_missions_completed

func _ready() -> void:
	reset()
	

func reset() -> void:
	xpos = FLAG_STARTING_X_POS
	ypos = FLAG_STARTING_Y_POS


func clear() -> void:
	# clear flags and start over
	for _c in get_children():
		_c.queue_free()
		
	xpos = FLAG_STARTING_X_POS
	missions_completed = 0
	reset()
	
	
func get_missions_completed() -> int:
	return missions_completed
		
	
# called via function reference after completing mission	
func flag_earned():
	
	missions_completed += 1
	
	# limit the number of flags shown
	if missions_completed <= MAX_FLAGS_DISPLAYED:
		var flag = create_flag.call_func()
		flag.position = Vector2(xpos, ypos)
		add_child(flag)
		xpos -= PIXELS_BETWEEN_FLAGS #update x position for next flag
	else:
		clear()
		flag_earned() # needed after reset
