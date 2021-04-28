extends Node

signal bullet_was_fired

const MAX_BULLETS = 3

var bullet_spawn_global_position:Reference
var create_bullet: Reference

var bullet_enabled:bool = true
var bullet_delay:int = 14


func _process(_delta) -> void:
	if bullet_enabled == false:
		bullet_delay -= 1
		if bullet_delay <= 0:
			bullet_delay = 14
			bullet_enabled = true
	
	
func reset() -> void:
	for bullet in get_children():
		bullet.queue_free()

	
func fire_bullet() -> void:
	if get_child_count() <= MAX_BULLETS and bullet_enabled == true:
		var spawn_position = bullet_spawn_global_position.call_func()
		var bullet = create_bullet.call_func()
		bullet.position = spawn_position
		add_child(bullet)
		emit_signal("bullet_was_fired") # will connect with sound player
