extends KinematicBody2D

signal rocket_hit

var launched = false
onready var ray1 = $"Sprite/RayCast1"
onready var ray2 = $"Sprite/RayCast2"

func _ready():
	$Animation.visible = false
	
func _process(_delta):
	var collision
	if launched == true:
		collision = move_and_collide(Vector2(0,-.5))
		# handle collision
	else:
		if ray1.is_colliding() == true or ray2.is_colliding() == true:
			pass
			$Sprite.visible = false
			$Animation.visible = true;
			$Animation.play()
			launched = true
			
func move(delta):
	position.y -= delta

func _on_Rocket_area_entered(area):
	if area.name == 'Bomb' or area.name == 'Bullet':
		var points
		# need to know if rocket was in flight or not
		if launched == true:
			points = 80
		else:
			points = 50
			
		emit_signal('rocket_hit',points)
		queue_free()
		#print(area.name)
		
func explode():
	var points
		# need to know if rocket was in flight or not
	if launched == true:
		points = 80
	else:
		points = 50
			
	emit_signal('rocket_hit',points)
	queue_free()
	
