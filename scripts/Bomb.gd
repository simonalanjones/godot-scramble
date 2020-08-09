extends KinematicBody2D

var path = PoolVector3Array()
var anim_counter = 0

# this should come in as a dependancy injection?
onready var Explosion_container = get_tree().get_root().get_node("World/Explosion_container")


# array holds x,y vectors and frame number of the animated sprite
func _ready():
	path.append(Vector3(0,0 ,0))
	path.append(Vector3(0,1 ,0))   
	path.append(Vector3(1,0 ,0))
	path.append(Vector3(1,0 ,0))
	
	path.append(Vector3(1,0 ,1))
	path.append(Vector3(1,0 ,1))
	path.append(Vector3(1,0 ,1))
	path.append(Vector3(1,0 ,1))
	
	path.append(Vector3(1,0 ,0))
	path.append(Vector3(1,0 ,0))
	path.append(Vector3(1,0 ,0))
	path.append(Vector3(1,0 ,0))
	
	path.append(Vector3(1,0 ,1))
	path.append(Vector3(1,0 ,1))
	path.append(Vector3(1,0 ,1))
	path.append(Vector3(1,0 ,1))
	
	path.append(Vector3(1,0 ,2))
	path.append(Vector3(1,1 ,2))
	path.append(Vector3(1,0 ,2))
	path.append(Vector3(1,0 ,2))
	path.append(Vector3(1,0 ,2))
	path.append(Vector3(1,1 ,2))
	path.append(Vector3(1,0 ,2))
	path.append(Vector3(1,0 ,2))
	
	path.append(Vector3(1,1 ,3))
	path.append(Vector3(1,0 ,3))
	path.append(Vector3(1,1 ,3))
	path.append(Vector3(1,1 ,3))
	path.append(Vector3(1,0 ,3))
	path.append(Vector3(1,1 ,3))
	path.append(Vector3(1,1 ,3))
	path.append(Vector3(1,1 ,3))
	
	path.append(Vector3(0,1 ,4))
	path.append(Vector3(0,1 ,4))
	
	path.append(Vector3(1,1 ,4))
	path.append(Vector3(1,1 ,4))
	path.append(Vector3(0,1 ,4))
	path.append(Vector3(1,1 ,4))
	path.append(Vector3(0,1 ,4))
	path.append(Vector3(1,1 ,4))
	path.append(Vector3(0,1 ,4))
	path.append(Vector3(0,1 ,4))
	path.append(Vector3(1,1 ,4))
	
	#set the initial sprite frame
	$Falling_animation.set_frame(0)

func _process(_delta):
	
	var collision
		
	if anim_counter < path.size():
		var _path:Vector3 = path[anim_counter]
		var x_offset = _path[0]
		var y_offset = _path[1]
			
		#add 1 to x when to account for camera moving away from sprite
		var movement = Vector2(x_offset+1,y_offset)
		var frame = int(_path[2])
		$Falling_animation.set_frame(frame)
		collision = move_and_collide(movement)
	else:
		collision = move_and_collide(Vector2(1,1))
		
	if collision:
		if collision.collider.has_method("explode"):
			collision.collider.explode()
			Explosion_container.spawn_explosion(collision.collider)
			explode() # remove bomb while spawning bomb explosion
		if collision.collider is TileMap:
			explode() # remove bomb while spawning bomb explosion
		
	anim_counter+=1
	
		
func get_class():
	return "Bomb"
	
	
func explode():	
		Explosion_container.spawn_explosion(self)
		queue_free()
