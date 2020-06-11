extends Camera2D

onready var is_moving = true
#onready var vel = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	#var ship_pos = $"../Spawn_point".get_position()
	#position.x = ship_pos.x
	

func _process(delta):
	if is_moving == true:
		position.x +=1+delta
