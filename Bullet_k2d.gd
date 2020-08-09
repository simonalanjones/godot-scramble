extends KinematicBody2D

onready var speed = 250
# this should come in as a dependancy injection?
onready var Explosion_container = get_tree().get_root().get_node("World/Explosion_container")


func _process(delta):	
	var velocity = Vector2()
	velocity.x +=1
	velocity = velocity * speed
	var collision = move_and_collide(velocity * delta)

	if collision:
		queue_free()
		if collision.collider.has_method("explode"):
			collision.collider.explode()
			Explosion_container.spawn_explosion(collision.collider)
			
			
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
