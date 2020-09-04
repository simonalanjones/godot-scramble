extends Node

## These references enable this script to call the player (Ship) move functions
## which removes the explicit binding between the player and the input checking

var player_left:Reference
var player_right:Reference
var player_up:Reference
var player_down:Reference
var player_enabled:Reference
var player_position:Reference

var fire_bullet:Reference
var fire_bomb:Reference


func _process(_delta):
	
	## player movement
	if Input.is_action_pressed("ui_up"):
		player_up.call_func()
	if Input.is_action_pressed("ui_down"):
		player_down.call_func()
	if Input.is_action_pressed("ui_left"):
		player_left.call_func()
	if Input.is_action_pressed("ui_right"):
		player_right.call_func()


	# TAB key is fire bullet
	if Input.is_action_just_pressed("ui_focus_next") and player_is_enabled():
		fire_bullet.call_func()
		
	# SPC key to release bomb	
	if Input.is_action_just_released("ui_accept") and player_is_enabled():
		fire_bomb.call_func()

	
func player_is_enabled():
	return player_enabled.call_func()
	
