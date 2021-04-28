extends KinematicBody2D

signal bomb_hit_landscape
signal bomb_hit_target

const CLASS_NAME = "Bomb"
const MOVE_DOWN_VECTOR = Vector2(1, 1)

var path = PoolVector3Array()
var anim_counter:int = 0

# array holds x,y vectors and frame number of the animated sprite
func _ready():
	#todo: convert this into a tres file and load data
	path.append(Vector3(0, 0 ,0))
	path.append(Vector3(0, 1 ,0))   
	path.append(Vector3(1, 0 ,0))
	path.append(Vector3(1, 0 ,0))
	
	path.append(Vector3(1, 0 ,1))
	path.append(Vector3(1, 0 ,1))
	path.append(Vector3(1, 0 ,1))
	path.append(Vector3(1, 0 ,1))
	
	path.append(Vector3(1, 0 ,0))
	path.append(Vector3(1, 0 ,0))
	path.append(Vector3(1, 0 ,0))
	path.append(Vector3(1, 0 ,0))
	
	path.append(Vector3(1, 0 ,1))
	path.append(Vector3(1, 0 ,1))
	path.append(Vector3(1, 0 ,1))
	path.append(Vector3(1, 0 ,1))
	
	path.append(Vector3(1, 0 ,2))
	path.append(Vector3(1, 1 ,2))
	path.append(Vector3(1, 0 ,2))
	path.append(Vector3(1, 0 ,2))
	path.append(Vector3(1, 0 ,2))
	path.append(Vector3(1, 1 ,2))
	path.append(Vector3(1, 0 ,2))
	path.append(Vector3(1, 0 ,2))
	
	path.append(Vector3(1, 1 ,3))
	path.append(Vector3(1, 0 ,3))
	path.append(Vector3(1, 1 ,3))
	path.append(Vector3(1, 1 ,3))
	path.append(Vector3(1, 0 ,3))
	path.append(Vector3(1, 1 ,3))
	path.append(Vector3(1, 1 ,3))
	path.append(Vector3(1, 1 ,3))
	
	path.append(Vector3(0, 1 ,4))
	path.append(Vector3(0, 1 ,4))
	
	path.append(Vector3(1, 1 ,4))
	path.append(Vector3(1, 1 ,4))
	path.append(Vector3(0, 1 ,4))
	path.append(Vector3(1, 1 ,4))
	path.append(Vector3(0, 1 ,4))
	path.append(Vector3(1, 1 ,4))
	path.append(Vector3(0, 1 ,4))
	path.append(Vector3(0, 1 ,4))
	path.append(Vector3(1, 1 ,4))
	#set the initial sprite frame
	$Falling_animation.set_frame(0)
	

func _process(_delta) -> void:	
	var collision
	if anim_counter < path.size():
		var _path:Vector3 = path[anim_counter]
		var x_offset = _path[0]
		var y_offset = _path[1]
			
		#add 1 to x to account for camera moving away from sprite
		var movement = Vector2(x_offset + 1, y_offset)
		var frame = int(_path[2])
		$Falling_animation.set_frame(frame)
		collision = move_and_collide(movement)
	else:
		collision = move_and_collide(MOVE_DOWN_VECTOR)
		
	if collision:
		# if target has a method named "explode" then call it
		if collision.collider.has_method("explode"):
			collision.collider.explode(self)  # tell target to explode itself
			emit_signal("bomb_hit_target", self)  # parent spawns explosion
		
		if collision.collider is TileMap:
			emit_signal("bomb_hit_landscape", self) # parent spawns explosion
					
	anim_counter += 1
	
		
func get_class() -> String:
	return CLASS_NAME
	
