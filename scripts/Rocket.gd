extends KinematicBody2D

signal rocket_hit

var launched = false

func _ready() -> void:
	$Animation.visible = false

func get_class() -> String: 
	return "Rocket"

	
func _process(_delta) -> void:
	#var collision
	if launched == true:
		var collision = move_and_collide(Vector2(0,-1))
		var local_pos = get_global_transform_with_canvas().get_origin()
		if local_pos.y < 40 or local_pos.x < 0:
			queue_free()
			
			
func launch() -> void:
	$Sprite.visible = false
	$Animation.visible = true;
	$Animation.play()
	launched = true
	add_to_group('inflight_rockets')
	

func explode() -> void:
	var points
		# need to know if rocket was in flight or not
	if launched == true:
		points = 80
	else:
		points = 50
			
	emit_signal('rocket_hit',points)
	queue_free()
	
	
func _on_VisibilityNotifier2D_screen_entered() -> void:
	add_to_group('visible_rockets')
		
		
func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()
