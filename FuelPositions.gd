extends TileMap

onready var tiles_used
const Fuel_scene = preload("res://Fuel.tscn")

func __ready():
	tiles_used = get_used_cells()
	for tile in tiles_used:
		var x = tile[0]
		var y = tile[1]
		var z = Vector2(x,y)
		var pos = map_to_world(z)
		
		var fuel = Fuel_scene.instance()
		fuel.position = Vector2(pos.x-4,pos.y)
		$"../Fuels".add_child(fuel)
		
	# don't need the tilemap to be visible after the fuel have been added
	hide()