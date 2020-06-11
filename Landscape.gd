extends Node2D


# preload all coloured pngs ??


var path_to_red_sprites = 'res://sprites/landscape/red/'
var path_to_blue_sprites = 'res://sprites/landscape/blue/'

var tilename



# example 'shapes_10' => 'shapes_10_red.png'
# later just add another var colour to make it one script
func calc_texture(tile_name,colour):
	return tile_name + '_red.png'
	
func _ready():
	pass
	#var red = load(path_to_red_sprites + "shapes_12_red.png")
	#path_to_red_sprites = 'res://sprites/landscape/red/'
	#print(path_to_red_sprites)

func go_red():
	var colour = 'red'
	var path = 'res://sprites/landscape/red/'
	var filename = path + str(tilename) + '_' + str(colour) + '.png'
	var file = load(filename)
	$Sprite.set_texture(file)

func go_blue():
	var colour = 'blue'
	var path = 'res://sprites/landscape/blue/'
	var filename = path + str(tilename) + '_' + str(colour) + '.png'
	var file = load(filename)
	$Sprite.set_texture(file)	

	
func set_texture(tile_name,colour):
	tilename = tile_name

	var path
	if colour == 'blue':
		path = 'res://sprites/landscape/blue/'
	elif colour == 'red':
		path = 'res://sprites/landscape/red/'
	elif colour == 'purple':
		path = 'res://sprites/landscape/purple/'
	elif colour == 'green':
		path = 'res://sprites/landscape/green/'

	var filename = path + str(tile_name) + '_' + str(colour) + '.png'
	var file = load(filename)
	$Sprite.set_texture(file)