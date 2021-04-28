extends CanvasLayer

onready var flag_holder = get_node("Flag_holder")
onready var lives = get_node("Lives")
onready var fuel_bar = get_node("Fuel_bar")
onready var attract_text = get_node("Attract_text")

var demo_flash_counter:int = 0
var attract_mode:bool = false

func _process(_delta):
	if attract_mode == true:
		# flashing attract mode text
		demo_flash_counter +=1
		if demo_flash_counter>30:
			demo_flash_counter = 0;
			attract_text.visible = !attract_text.visible
			
			
func _hide() -> void:
	attract_mode = false
	attract_text.visible = false
	for child in get_children():
		if child is Node2D:
			child.visible = false
			
			
func _show() -> void:
	attract_mode = false
	attract_text.visible = true
	for child in get_children():
		if child is Node2D:
			child.visible = true
			
			
func switch_to_demo_mode() -> void:
	attract_text.visible = true
	attract_mode = true
	demo_flash_counter = 0
	flag_holder.visible = false
	fuel_bar.visible = true
	lives.visible = false
	
	
func switch_to_player_mode() -> void:
	attract_text.visible = false
	attract_mode = false
	flag_holder.visible = true
	fuel_bar.visible = true
	lives.visible = true
	
	
func switch_off() -> void:
	attract_text.visible = false
	attract_mode = false
	flag_holder.visible = false
	fuel_bar.visible = false
	lives.visible = false
	
	
	
