extends KinematicBody2D

onready var speed = 61
onready var velocity = Vector2()


var left_boundary_reached = false
var right_boundary_reached = false

const Bomb_scene = preload("res://scenes/Bomb.tscn")
const Bullet_scene = preload("res://Bullet_k2d.tscn")

func _ready():
	$Sprite.playing = true

func get_input():
	
	velocity = Vector2()
	
	if Input.is_action_pressed("ui_up") and $Sprite.global_position.y>41:
		velocity.y -=1
		velocity.x +=1
		
	if Input.is_action_pressed("ui_down"):
		velocity.y +=1
		velocity.x +=1
		
	if Input.is_action_pressed("ui_left") and left_boundary_reached == false:
		velocity.x = 0
	else:
		velocity.x+=1
		
	if Input.is_action_pressed("ui_right") and right_boundary_reached == false:
		velocity.x+=1
		
	velocity = velocity.normalized() * speed
			
	
func _physics_process(delta):
	
		get_input()
		move_and_collide(velocity * delta)
		
		var cx = $"../TileMap/Camera2D".get_camera_position().x
		var sx = $Sprite.position.x
		
		if (sx-cx)<1:
			left_boundary_reached = true
		else:
			left_boundary_reached = false
			
		if (sx-cx) > 100:
			right_boundary_reached = true
		else:
			right_boundary_reached = false
		
		if Input.is_action_just_pressed("ui_focus_next"):
			if $"../Bullets".get_child_count()<4:
				var bullet = Bullet_scene.instance()
				bullet.position = get_node("Sprite/Bullet_spawn").global_position
				$"../Bullets".add_child(bullet)
				
		if Input.is_action_just_released("ui_accept"):
			if $"../Bombs".get_child_count() <2000000:  # change to 2
				var bomb = Bomb_scene.instance()
				bomb.position = Vector2($Sprite.global_position.x+13,$Sprite.global_position.y+10)
				$"../Bombs".add_child(bomb)
		"""
		if Input.is_action_pressed("ui_up") and $Sprite.global_position.y>41:
			$Sprite.position.y -=1
		if Input.is_action_pressed("ui_down"):
			$Sprite.position.y +=1
		if Input.is_action_pressed("ui_left") and left_boundary_reached == false:
			$Sprite.position.x -=0
		else:
			$Sprite.position.x+=1+delta
				
		if Input.is_action_pressed("ui_right") and right_boundary_reached == false:
			$Sprite.position.x+=1.5+delta
			"""
			

	
func _on_Area2D_area_entered(_area):
	left_boundary_reached = true
	#print('I got hit.')
	#print(area.name)
	
func _on_Area2D_area_shape_entered(_area_id, _area, _area_shape, _self_shape):
	pass
	#print('I got hit..')

func _on_Area2D_body_shape_entered(_body_id, body, _body_shape, _area_shape):
	
	#print('I got hit...')
	#print(body)
	if body is TileMap:
		pass
		#print('hit by tilemap')

func _on_Screen_left_edge_area_entered(_area):
	left_boundary_reached = true

func _on_Screen_left_edge_area_exited(_area):
	left_boundary_reached = false

func _on_Screen_right_edge_area_entered(_area):
	right_boundary_reached = true
	
func _on_Screen_right_edge_area_exited(_area):
	right_boundary_reached = false
