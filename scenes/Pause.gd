extends Node2D

func _input(event):
	if event.is_action_pressed("pause"):
		#print("Game Paused")
		get_tree().paused = !get_tree().paused
		"""
		var inflight_rockets = get_tree().get_nodes_in_group("inflight_rockets")
		
		print('======')
		print(inflight_rockets.size())
		print(get_tree().get_nodes_in_group("inflight_rockets"))
		for rocket in inflight_rockets:
			#print(rocket.get_name())
			var c = rocket.get_global_transform_with_canvas().get_origin()
			print(c)
			#print(rocket.position.x)
			#print(rocket.position.y)
		print('======')
		"""

