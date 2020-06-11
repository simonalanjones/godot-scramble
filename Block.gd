extends Node2D


const black_texture = preload("res://block.png")
const red_texture = preload("res://block-red.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func go_red():
	$Sprite.texture = red_texture
	
func go_black():
	$Sprite.texture = black_texture