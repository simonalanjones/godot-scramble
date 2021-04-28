extends KinematicBody2D

signal bullet_hit_target
const SPEED = 250
const CLASS_NAME = "Bullet"


func get_class() -> String:
	return CLASS_NAME
	
func _process(delta) -> void:	
	var velocity = Vector2()
	velocity.x += 1
	velocity = velocity * SPEED
	var collision = move_and_collide(velocity * delta)

	if collision:
		queue_free()
		if collision.collider.has_method("explode"):
			collision.collider.explode(self)
			emit_signal("bullet_hit_target", self)
			
						
func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()
