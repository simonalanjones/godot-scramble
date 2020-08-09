extends KinematicBody2D


func _process(delta):
	print('this shouldnt be printed!!')
	translate(Vector2(4+delta,0))
		
func _on_VisibilityNotifier2D_screen_exited():
	print('left screen')
	queue_free()

func _on_Bomb_area_entered(area):
	print(area)
	queue_free()


func _on_Bomb_body_shape_entered(body_id, body, body_shape, area_shape):
	if body is TileMap:
		print(body.name)
		queue_free()
