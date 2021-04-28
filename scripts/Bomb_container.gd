extends Node

signal bomb_hit_landscape
signal bomb_was_dropped

const MAX_BOMBS = 2

# Access to functions we will need
var bomb_spawn_global_position:Reference
var create_bomb: Reference
var spawn_explosion: Reference


func reset() -> void:
	for bomb in get_children():
		bomb.queue_free()
		
		
func fire_bomb():
	if get_child_count() < MAX_BOMBS:
		var bomb = create_bomb.call_func()
		bomb.connect("bomb_hit_landscape", self, "on_bomb_hit_landscape")
		bomb.connect("bomb_hit_target", self, "on_bomb_exploded")
		bomb.position = bomb_spawn_global_position.call_func()
		add_child(bomb)
		emit_signal("bomb_was_dropped", self) # will connect with sound player


func on_bomb_hit_landscape(bomb: KinematicBody2D):
	emit_signal("bomb_hit_landscape", bomb)  # this will trigger sound?
	spawn_explosion.call_func(bomb)
	bomb.queue_free()
	

func on_bomb_exploded(bomb: KinematicBody2D):
	spawn_explosion.call_func(bomb)
	bomb.queue_free()
