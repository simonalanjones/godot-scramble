extends CanvasLayer

onready var starfield_num: int = 0
onready var starfields: Array = []

const SECONDS_BETWEEN_FRAMES = 0.8
const SCREEN_WIDTH = 224
const SCREEN_HEIGHT = 256
const MAX_STARS = 64
const MAX_STARFIELDS = 4
		
# current starfield texture which is used in wipe and placed above everything
func current_starfield() -> Texture:
	get_node("wait_timer").wait_time = SECONDS_BETWEEN_FRAMES # sync starfield and wipe
	return starfields[starfield_num]

			
func _ready() -> void:	
	# setup sprite to hold starfield textures
	var starfield_sprite: Sprite = Sprite.new()
	starfield_sprite.name = "starfield_sprite"
	starfield_sprite.centered = false
	add_child(starfield_sprite)
	
	# setup timer between frames
	var timer: Timer = Timer.new()
	timer.name = "wait_timer"
	timer.wait_time = SECONDS_BETWEEN_FRAMES
	var _t = timer.connect("timeout", self, "_on_Timer_timeout")
	timer.autostart = true
	add_child(timer)	
	
	var random_star_colours: Array = []
	var random_star_positions: Array = []
	var low: float
	var high: float
	var rng = RandomNumberGenerator.new()
	rng.randomize()

	for _n in range(0, MAX_STARS):
		var rand:float = rng.randf()
		if rand >= 0.7:
			low = 0.7
			high = 1
		elif rand <= 0.3:
			low = 0
			high = 0.5
		else:
			low = 0.5
			high = 1

		random_star_positions.append(Vector2(rng.randi_range(0, 223), rng.randi_range(0, 255)))
		random_star_colours.append(Vector3(rng.randf_range(low, high), rng.randf_range(low, high), rng.randf_range(low, high)))
	
	starfields.append(make_starry_image(random_star_positions, random_star_colours))
	starfields.append(make_starry_image(random_star_positions.slice(0, 31), random_star_colours.slice(0, 31)))
	starfields.append(make_starry_image(random_star_positions.slice(15, 46), random_star_colours.slice(15, 46)))
	starfields.append(make_starry_image(random_star_positions.slice(32, 63), random_star_colours.slice(32, 63)))
	get_node("starfield_sprite").set_texture(starfields[starfield_num])
	get_node("starfield_sprite").set_position(Vector2.ZERO)
	
	
	
func make_starry_image(star_positions: Array, star_colours: Array) -> Texture:
	var img = Image.new()
	img.create(SCREEN_WIDTH, SCREEN_HEIGHT, false, Image.FORMAT_RGB8)
	img.fill(Color(0, 0, 0))
	img.lock()
	for n in range(0, star_positions.size()):
		img.set_pixel(star_positions[n][0], star_positions[n][1], 
			Color(star_colours[n][0], star_colours[n][1], star_colours[n][2]))
	img.unlock()
	var texture = ImageTexture.new()
	texture.create_from_image(img)
	return texture
	
	
func _on_Timer_timeout() -> void:
	starfield_num += 1
	if starfield_num == MAX_STARFIELDS:
		starfield_num = 0
	get_node("starfield_sprite").set_texture(starfields[starfield_num])

	
func turn_off_stars() -> void:
	get_node("starfield_sprite").visible = false
	

func turn_on_stars() -> void:
	get_node("starfield_sprite").visible = true
