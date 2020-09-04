extends Node

var bullet_enabled:bool = true
var bullet_delay:int = 14
var bullet_spawn_global_position:Reference

onready var Bullet_scene: PackedScene = preload("res://scenes/Bullet.tscn")

func _process(_delta):
	if bullet_enabled == false:
		bullet_delay -= 1
		if bullet_delay <= 0:
			bullet_delay = 14
			bullet_enabled = true
	
func fire_bullet():
	if get_child_count() <= 3 and bullet_enabled == true:
		var spawn_position = bullet_spawn_global_position.call_func()
		var bullet = Bullet_scene.instance()
		bullet.position = spawn_position
		add_child(bullet)
		
