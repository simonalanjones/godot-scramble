extends KinematicBody2D

signal rocket_hit

var launched = false

func _ready():
	$Animation.visible = false
	
	
func get_class(): 
	return "Rocket"
	
	
func _process(_delta):
	if launched == true:
		var _collision = move_and_collide(Vector2(0,-1))
		var local_pos = get_global_transform_with_canvas().get_origin()
		if local_pos.y < 40 or local_pos.x < 1:
			queue_free()
			
			
func launch():
	$Sprite.visible = false
	$Animation.visible = true;
	$Animation.play()
	launched = true
	add_to_group('inflight_rockets')
	
	
func explode():
	var points
		# need to know if rocket was in flight or not
	if launched == true:
		points = 80
	else:
		points = 50
			
	emit_signal('rocket_hit',points)
	queue_free()
	
	
func _on_VisibilityNotifier2D_screen_entered():
	add_to_group('visible_rockets')
