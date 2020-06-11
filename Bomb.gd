extends KinematicBody2D

var path = PoolVector2Array()

var anim_counter = 0
var enabled

func _ready():
	
	path.append(Vector2(2,0))
	path.append(Vector2(2,0))
	path.append(Vector2(2,0))
	path.append(Vector2(2,0))
	path.append(Vector2(2,0))
	path.append(Vector2(2,0))
	path.append(Vector2(2,0))
	path.append(Vector2(2,0))
	path.append(Vector2(2,0))
	path.append(Vector2(2,0))
	path.append(Vector2(2,0))
	path.append(Vector2(2,0))
	path.append(Vector2(2,0))
	path.append(Vector2(2,0))
	path.append(Vector2(2,0))
	path.append(Vector2(2,0))

	path.append(Vector2(2,1))	
	path.append(Vector2(2,1))
	path.append(Vector2(2,1))
	path.append(Vector2(2,1))
	path.append(Vector2(2,1))

	path.append(Vector2(2,1))	
	path.append(Vector2(2,1))	
	path.append(Vector2(2,1))
	path.append(Vector2(2,1))	
	path.append(Vector2(2,1))	
	path.append(Vector2(2,1))
	path.append(Vector2(2,1))
	path.append(Vector2(2,1))
	path.append(Vector2(2,1))
	path.append(Vector2(2,1))
	path.append(Vector2(2,1))	
	path.append(Vector2(2,1))		
	path.append(Vector2(2,1))	
	path.append(Vector2(2,1))
	
	$Falling_animation.set_frame(0)
	$Falling_animation.play()
	enabled = true
	
func _process(delta):
	
	if enabled == true:
		
		var collision
		if anim_counter < path.size():
			collision = move_and_collide(path[anim_counter])
		else:
			collision = move_and_collide(Vector2(1+delta,1+delta))
		
		if collision:
			#print(collision.collider.name)
			if collision.collider.has_method('explode'):
				collision.collider.explode()
				explode()
			if collision.collider is TileMap:
				explode()
		
		anim_counter+=1
		
		
func explode():	
		enabled = false
		$Falling_animation.visible = false
		$Explode_animation.visible = true
		$Explode_animation.set_frame(0)
		$Explode_animation.play('default')
		
func _on_Explode_animation_animation_finished():
	queue_free()