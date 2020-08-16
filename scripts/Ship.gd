extends Node2D

signal ship_was_hit
signal second_timeout
signal crash_animation_complete

var enabled:bool = true
var fuel_depleted:bool = false
var spawn_position:Vector2 = Vector2(10,80)
var scroll_time:float = 0

const Bomb_scene = preload("res://scenes/Bomb.tscn")
const Bullet_scene = preload("res://scenes/Bullet_k2d.tscn")

func _ready()->void:
	set_global_position(spawn_position)


# via signal in World.gd	
func fuel_has_depleted()->void:
	fuel_depleted = true


func reset()->void:
	set_global_position(spawn_position)
	visible = true
	scroll_time = 0
	enabled = true
	fuel_depleted = false
	

func disable()->void:
	enabled = false
	
func enable()->void:
	scroll_time = 0
	enabled = true
	
	
func _process(delta)->void:
		
	# every one second moving add 10 points
	if enabled == true:
		
		scroll_time += delta
		if scroll_time > 1:
			scroll_time = 0
			emit_signal('second_timeout')
	
	# make ship move towards landscape if fuel is out
	if fuel_depleted == true and enabled == true:
		translate(Vector2(1,1))
		
	if enabled == true and not fuel_depleted:
					
		if Input.is_action_just_pressed("ui_focus_next"):
			if $"../Bullets".get_child_count() < 4:
				var bullet = Bullet_scene.instance()
				bullet.position = get_node("Sprite/Bullet_spawn").global_position
				$"../Bullets".add_child(bullet)
				
		if Input.is_action_just_released("ui_accept"):
			if $"../Bombs".get_child_count() < 2 :
				var bomb = Bomb_scene.instance()
				bomb.position = get_node("Sprite/Bomb_spawn").global_position
				$"../Bombs".add_child(bomb)
		
		# get position of ship relative to canvas
		var local_pos = get_global_transform_with_canvas().get_origin()
			
		if Input.is_action_pressed("ui_up") and local_pos.y > 41:
			position.y -= 1
		if Input.is_action_pressed("ui_down"):
			position.y += 1
		if Input.is_action_pressed("ui_left") and local_pos.x > 10:
			position.x -= 0
		else:
			position.x += 1
				
		if Input.is_action_pressed("ui_right") and local_pos.x < 90:
			position.x += 1.5
			
			
# this can trap collision with ground targets and tilemap
func _on_Area2D_body_shape_entered(_body_id, _body, _body_shape, _area_shape)->void:
	if enabled == true:
		$Sprite.speed_scale = 4
		#$Sprite.play('crash')
		#emit_signal('ship_was_hit')
		#enabled = false
		
		
func _on_Sprite_animation_finished()->void:
	if $Sprite.get_animation() == "crash":
		$Sprite.speed_scale = 10
		$Sprite.play('default')
		emit_signal('crash_animation_complete')
