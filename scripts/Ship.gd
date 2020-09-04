extends Node2D

signal ship_was_hit
signal crash_animation_complete

var enabled:bool = false
var fuel_depleted:bool = false
var spawn_position:Vector2 = Vector2(10,80)
var local_position:Vector2

func _ready() -> void:
	set_global_position(spawn_position)


func bullet_spawn_position() -> Vector2:
	return get_node("Sprite/Bullet_spawn").global_position


func bomb_spawn_position() -> Vector2:
	return get_node("Sprite/Bomb_spawn").global_position

	
# via signal in World.gd	
func fuel_has_depleted() -> void:
	fuel_depleted = true


func reset() -> void:
	set_global_position(spawn_position)
	visible = true
	enabled = true
	fuel_depleted = false
	

func disable() -> void:
	enabled = false
	
	
func enable() -> void:
	enabled = true


func is_enabled() -> bool:
	if enabled == true:
		return true
	else:
		return false
	
	
func _process(_delta) -> void:
	# get position of ship relative to canvas
	local_position = get_global_transform_with_canvas().get_origin()
		
	# make ship move towards landscape if fuel is out
	if fuel_depleted == true and enabled == true:
		translate(Vector2(1,1))
		
	if enabled == true and not fuel_depleted:
		position.x += 1
		

func move_up():
	if local_position.y > 41 and enabled == true:
		position.y -= 1
	
func move_down():
	if enabled == true:
		position.y += 1
	
func move_left():
	if enabled == true and local_position.x > 10:
		position.x -= 1
	
func move_right():
	if enabled == true and local_position.x < 90:
		position.x += 1.5
				
			
# this can trap collision with ground targets and tilemap
func _on_Area2D_body_shape_entered(_body_id, _body, _body_shape, _area_shape) -> void:
	if enabled == true:
		$Sprite.speed_scale = 4
		$Sprite.play('crash')
		emit_signal('ship_was_hit')
		enabled = false
		
		
func _on_Sprite_animation_finished() -> void:
	if $Sprite.get_animation() == "crash":
		$Sprite.speed_scale = 10
		$Sprite.play('default')
		emit_signal('crash_animation_complete')
