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
#var bullet_spawn_position:Reference
#var rocket_spawn_position:Reference

func _ready():
	pass


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
		
		#Bullet_container.fire_bullet()
		## emit_signal("bullet_fire_pressed") or use the bullet container node
		
		## pass to bullet container to decide
		## pass the ships position


#### PLACE THESE IN THE BULLET AND ROCKET CONTAINER NO NEED FOR HERE!!
#func bullet_spawn_position():
#	return bullet_spawn_position.call_func()
	
#func rocket_spawn_position():
#	return rocket_spawn_position.call_func()
	
func player_is_enabled():
	return player_enabled.call_func()
	
	
## ALL THE ABOVE GO ELSEWHERE
