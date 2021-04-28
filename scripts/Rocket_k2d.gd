extends KinematicBody2D

signal rocket_hit
signal rocket_exited_screen

const CLASS_NAME = "Rocket"
const INFLIGHT_POINTS = 80
const STATIC_POINTS = 50
const MOVE_VECTOR = Vector2(0, -1)
const MIN_Y_POSITION = 40
const MIN_X_POSITION = 1

var launched:bool = false

func _ready() -> void:
	$Animation.visible = false
	

func get_class() -> String:
	return CLASS_NAME
	

func _process(_delta) -> void:
	if launched == true:
		var _collision = move_and_collide(MOVE_VECTOR)
		var local_position = get_global_transform_with_canvas().get_origin()
		if local_position.y < MIN_Y_POSITION or local_position.x < MIN_X_POSITION:
			emit_signal('rocket_exited_screen', self)
			
			
func launch() -> void:
	$Sprite.visible = false
	$Animation.visible = true;
	$Animation.play()
	launched = true
	add_to_group('inflight_rockets')
	
	
func explode(projectile: KinematicBody2D) -> void:

	var points
		# need to know if rocket was in flight or not
	if launched == true:
		points = INFLIGHT_POINTS
	else:
		points = STATIC_POINTS
	emit_signal('rocket_hit', points, self, projectile)
	
	
func _on_VisibilityNotifier2D_screen_entered() -> void:
	add_to_group('visible_rockets')
