extends CanvasLayer
signal lives_depleted

onready var lives:int = 3

func _ready():
	show_lives()

func show_lives()->void:
	match lives:
		0,1:
			$ship_1.visible = false
			$ship_2.visible = false
			$ship_3.visible = false
		2:
			$ship_1.visible = true
			$ship_2.visible = false
			$ship_3.visible = false
		3:
			$ship_1.visible = true
			$ship_2.visible = true
			$ship_3.visible = false			
		4:
			$ship_1.visible = true
			$ship_2.visible = true
			$ship_3.visible = true
	

func lose_life()->void:
	lives -= 1
	show_lives()
	if lives < 0:
		emit_signal("lives_depleted")
		
			
func extra_life()->void:
	lives += 1
	show_lives()
