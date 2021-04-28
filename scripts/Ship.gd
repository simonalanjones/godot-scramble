extends KinematicBody2D

signal ship_was_hit
signal crash_animation_complete

# ship movement vectors
const MOVE_TOWARDS_GROUND_VECTOR = Vector2(1, 1)
const MOVE_FORWARDS_VECTOR = Vector2(1, 0)
const MOVE_UP_VECTOR = Vector2(0, -1)
const MOVE_DOWN_VECTOR = Vector2(0, 1)
const MOVE_LEFT_VECTOR = Vector2(-1, 0)
const MOVE_RIGHT_VECTOR = Vector2(1.5, 0)
const CLASS_NAME = "Ship"

# screen limits for ship
const MIN_X_POSITION = 10
const MAX_X_POSITION = 90
const MIN_Y_POSITION = 41

# ship animation speeds
const CRASH_ANIMATION_SPEED_SCALE = 4
const FLYING_ANIMATION_SPEED_SCALE = 10

var enabled: bool = true
var spawn_position: Vector2 = Vector2(10,80)
var local_position: Vector2


func _ready() -> void:
	set_global_position(spawn_position)
	
	
func get_class() -> String:
	return CLASS_NAME
	
		
func bullet_spawn_position() -> Vector2:
	return get_node("Sprite/Bullet_spawn").global_position
	
	
func bomb_spawn_position() -> Vector2:
	return get_node("Sprite/Bomb_spawn").global_position


func hide():
	visible = false
	
	
func reset() -> void:
	set_global_position(spawn_position)
	visible = true
	enabled = true
	

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
		

# move player towards ground when fuel is out in 'playing' state
func move_towards_ground():
	translate(MOVE_TOWARDS_GROUND_VECTOR)

			
# normal move right aligns with camera
func move_forward():
	if enabled == true:
		translate(MOVE_FORWARDS_VECTOR)

	
func move_up():
	if local_position.y > MIN_Y_POSITION and enabled == true:
		translate(MOVE_UP_VECTOR)
	
	
func move_down():
	if enabled == true:
		translate(MOVE_DOWN_VECTOR)
	
	
func move_left():
	if enabled == true and local_position.x > MIN_X_POSITION:
		translate(MOVE_LEFT_VECTOR)
	
	
func move_right():
	if enabled == true and local_position.x < MAX_X_POSITION:
		translate(MOVE_RIGHT_VECTOR)
				
			
# this can trap collision with ground targets and tilemap
func _on_Area2D_body_shape_entered(_body_id, _body, _body_shape, _area_shape) -> void:
	
	if enabled == true:
		if _body is Node:
			if _body.has_method("explode") and _body.get_class() != "Base":  # can't kamikaze the base
				get_node("/root/Scramble/Game/Explosion_container").spawn_explosion(_body)
				_body.explode(self)
		
		$Sprite.speed_scale = CRASH_ANIMATION_SPEED_SCALE
		$Sprite.play('crash')
		emit_signal('ship_was_hit')
		enabled = false

		
		
func _on_Sprite_animation_finished() -> void:
	if $Sprite.get_animation() == "crash":
		$Sprite.speed_scale = FLYING_ANIMATION_SPEED_SCALE
		$Sprite.play('default')
		hide()
		emit_signal('crash_animation_complete')
		
