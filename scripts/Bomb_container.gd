extends Node

onready var Bomb_scene: PackedScene = preload("res://scenes/Bomb.tscn")
var bomb_spawn_global_position:Reference

func fire_bomb():
	if get_child_count() < 2:
		var bomb = Bomb_scene.instance()
		bomb.position = bomb_spawn_global_position.call_func()
		add_child(bomb)
