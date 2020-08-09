extends KinematicBody2D

var path:PoolVector2Array = PoolVector2Array()
var pointer:int = 0


func _ready():
	path.append(Vector2(0,-1))  
	path.append(Vector2(0,-2))
	path.append(Vector2(0,-2))
	path.append(Vector2(0,-2))
	path.append(Vector2(0,-2))
	path.append(Vector2(0,-2))
	path.append(Vector2(0,-2))
	path.append(Vector2(0,-2))
	path.append(Vector2(0,-2))
	path.append(Vector2(-2,-2))
	path.append(Vector2(0,-2))
	path.append(Vector2(-2,-2))
	path.append(Vector2(0,-2))
	path.append(Vector2(-2,-2))
	path.append(Vector2(-2,-2))
	path.append(Vector2(-2,-2))
	path.append(Vector2(-2,-2))
	path.append(Vector2(-2,0))
	path.append(Vector2(-2,0))
	path.append(Vector2(-2,2))
	path.append(Vector2(-2,2))
	path.append(Vector2(-2,2))
	path.append(Vector2(-2,2))
	path.append(Vector2(-2,2))
	path.append(Vector2(-2,2))
	path.append(Vector2(0,2))
	path.append(Vector2(-2,2))
	path.append(Vector2(0,2))
	path.append(Vector2(-2,2))
	path.append(Vector2(0,2))
	path.append(Vector2(-2,2))
	path.append(Vector2(0,2))
	path.append(Vector2(0,2))
	path.append(Vector2(0,2))
	path.append(Vector2(0,2))
	path.append(Vector2(0,2))
	path.append(Vector2(-2,2))
	path.append(Vector2(0,2))
	path.append(Vector2(0,2))
	path.append(Vector2(0,2))
	path.append(Vector2(-2,2))
	path.append(Vector2(0,2))
	path.append(Vector2(0,2))
	path.append(Vector2(0,2))
	path.append(Vector2(0,2))
	path.append(Vector2(-2,2))
	path.append(Vector2(0,2))
	path.append(Vector2(-2,2))
	path.append(Vector2(0,2))
	path.append(Vector2(0,2))
	path.append(Vector2(-2,2))
	path.append(Vector2(-2,2))
	path.append(Vector2(-2,2))
	path.append(Vector2(-2,0))
	path.append(Vector2(-2,0))
	path.append(Vector2(-2,0))
	path.append(Vector2(-2,-2))
	path.append(Vector2(-2,-2))
	path.append(Vector2(-2,-2))
	path.append(Vector2(-1,-2))
	path.append(Vector2(0,-2))
	path.append(Vector2(-2,-2))	
	path.append(Vector2(0,-2))
	path.append(Vector2(-2,-2))
	path.append(Vector2(0,-2))
	path.append(Vector2(-2,-2))
	path.append(Vector2(0,-2))
	path.append(Vector2(-2,-2))
	path.append(Vector2(0,-2))
	path.append(Vector2(0,-2))
	path.append(Vector2(0,-2))
	path.append(Vector2(0,-2))
	path.append(Vector2(0,-2))
	path.append(Vector2(0,-2))
	
func get_class(): 
	return "Ufo"
		
func _process(_delta):
	var p:Vector2 = path[pointer]
	var x = p[0]
	var y = p[1]
	translate(Vector2(1,0))
	translate(Vector2(x,y))
	pointer +=1
	if pointer == path.size():
		pointer = 0

func explode():
	queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
