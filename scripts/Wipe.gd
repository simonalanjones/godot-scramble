extends Node2D

class_name Screen_wipe

signal wipe_complete

const WIPE_START_X = 0
const WIPE_END_X = 224
const WIPE_INCREMENT = 8
const WIPE_HEIGHT = 256

onready var Wipe_sprite: Sprite
onready var current_starfield: Reference
onready var camera_property: Reference


func play():
	Wipe_sprite = Sprite.new()
	Wipe_sprite.z_as_relative = true
	Wipe_sprite.region_enabled = true
	Wipe_sprite.centered = false
	Wipe_sprite.visible = true
	Wipe_sprite.name = "Wipe"
	# get the current starfield texture
	Wipe_sprite.set_texture(current_starfield.call_func())
	# start off with a 0 width rect2 region
	Wipe_sprite.set_region_rect(Rect2(0, 0, 0, 0))
	Wipe_sprite.set_position(Vector2.ZERO)
	add_child(Wipe_sprite)
	
	var camera_position = camera_property.call_func()
	# move wipe node into position of camera
	position.x = camera_position.x

	# loop for width of screen
	for width in range(WIPE_START_X, WIPE_END_X, WIPE_INCREMENT):
		# create a frame delay in each loop cycle
		yield(get_tree(), "idle_frame")
		# change rect region of sprite to width var
		Wipe_sprite.set_region_rect(Rect2(0, 0, width, WIPE_HEIGHT))
	
	emit_signal("wipe_complete")
	yield(get_tree(), "idle_frame")
	get_node("Wipe").queue_free()
