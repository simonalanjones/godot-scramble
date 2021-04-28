extends Node2D

signal lives_depleted

const MAX_LIVES = 3
const MAX_FLASH_COUNT = 5
const MAX_FLASHES = 18

const SHIP_STARTING_X_POS = 0
const SHIP_STARTING_Y_POS = 248
const PIXEL_SPACING_BETWEEN_SHIPS = 16

var lives:int = 3

# vars to make flashing extra life - see process
var flash_counter: int = 0
var is_flashing: bool = false
var total_flashes: int = 0
var node_to_flash: Node2D # the extra life we're going to flash
var create_hud_ship: Reference # returns a Hud-life


func _ready() -> void:
	draw_ships(lives)


func _process(_delta):
	if is_flashing == true:
		flash_counter += 1
		if flash_counter > MAX_FLASH_COUNT:
			flash_counter = 0
			total_flashes += 1
			if is_instance_valid(node_to_flash):
				node_to_flash.visible = !node_to_flash.visible
		if total_flashes > MAX_FLASHES and is_instance_valid(node_to_flash):
			is_flashing = false
			node_to_flash.visible = true
			
	
func reset():
	lives = MAX_LIVES
	draw_ships(lives)
	
		
func draw_ships(amount: int):
	for n in get_children():
		n.queue_free()
	
	if amount > 0:
		var xpos = SHIP_STARTING_X_POS
		var ypos = SHIP_STARTING_Y_POS
		for _r in range(1, amount + 1):
			var ship = create_hud_ship.call_func()
			ship.global_position = Vector2(xpos,ypos)
			add_child(ship)
			xpos += PIXEL_SPACING_BETWEEN_SHIPS	
			
			
func show_lives() -> void:
	draw_ships(lives-1)
	
	
func lose_life() -> void:
	lives -= 1
	show_lives()
	if lives < 1:
		emit_signal("lives_depleted")
		
		
func extra_life() -> void:
	lives += 1
	show_lives()
	flash_extra_life()
	
	
func flash_extra_life():
	var ships = get_children()
	var count = ships.size() - 1
	node_to_flash = ships[count]
	is_flashing = true
	flash_counter = 0
	total_flashes = 0
