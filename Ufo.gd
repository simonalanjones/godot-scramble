extends Node2D

var path = PoolVector2Array()

func _ready():
	
	path.append(Vector2(-2,0))
	path.append(Vector2(2,0))
	path.append(Vector2(2,0))
	path.append(Vector2(2,0))
	path.append(Vector2(2,0))
	
func _process(_delta):
	pass