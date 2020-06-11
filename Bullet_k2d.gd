extends KinematicBody2D

onready var speed = 250
onready var velocity = Vector2()
onready var enabled = true

func _process(delta):
	
	if enabled == true:
		
		velocity = Vector2()
		velocity.x +=1
		velocity = velocity * speed
		var collision = move_and_collide(velocity * delta)
	
		if collision:
			# test if collision is with rocket
			if "launched" in collision.collider:
				# if is rocket see if launched is true
				if collision.collider.launched == true:
					# explode the rocket
					collision.collider.explode()
					# explode the bullet
					explode()
				else:
					# rocket not launched but ok to explode it
					collision.collider.explode()
					# and just remove bullet from screen
					queue_free()
					
			# some other type of ground target?		
			elif collision.collider.has_method('explode'):
				collision.collider.explode()
				explode()
			# hit the landscape?
			elif collision.collider is TileMap:
				queue_free()
	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	
func explode():	
		enabled = false
		$Sprite.visible = false
		$Explode_animation.visible = true
		$Explode_animation.set_frame(0)
		$Explode_animation.play('default')
		
func _on_Explode_animation_animation_finished():
	queue_free()
	
