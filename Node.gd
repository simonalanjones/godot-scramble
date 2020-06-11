extends Node2D

var vel = Vector2()
var screensize = Vector2()
var extents

export var speed = 60

# Called when the node enters the scene tree for the first time.
func _ready():
	screensize = get_viewport_rect().size
	extents = get_node("Ship").get_texture().get_size()/2
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _process(delta):
	
		var input = Vector2(0,0)
		if Input.is_action_pressed("ui_up"):
			input.y = -1
		if Input.is_action_pressed("ui_down"):
			input.y = 1
		if Input.is_action_pressed("ui_left"):
			input.x = -1
		if Input.is_action_pressed("ui_right"):
			input.x = 1
		vel = input * speed
		var pos = get_position() + vel * delta
		pos.x = clamp(pos.x, 0, (screensize.x - extents.x))
		set_position(pos)