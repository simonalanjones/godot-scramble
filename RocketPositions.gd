extends TileMap

var positions = PoolVector2Array()

func get_positions():
	for tile in get_used_cells():
		var x = tile[0]
		var y = tile[1]
		var z = Vector2(x,y)
		var pos = map_to_world(z)
		
		positions.append(Vector2(pos.x-4,pos.y))
				
	return positions