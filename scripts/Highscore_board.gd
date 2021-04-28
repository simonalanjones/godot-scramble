extends Node2D

const RANKING_NAMES = [
	"1ST", "2ND", "3RD", "4TH", "5TH", "6TH", "7TH", "8TH", "9TH", "10TH"
	]
const POINTS_TEXT = "PTS"
const PLACEHOLDER_SCORE = "00000"
const HEADER_TEXT = "- SCORE RANKING -"
const FONT_SIZE = 8
const MAX_SCORES = 10

const RANK_X_POSITION = 57
const SCORE_X_POSITION = 104
const PTS_X_POSITION = 152
const LINE_SPACING = 16
const HEADER_POSITION = Vector2(40, 33)

const COLOUR_TOP_ROWS = "e0e000"
const COLOUR_MID_ROWS = "00c3d9"
const COLOUR_LOW_ROWS = "8500d9"

var line_y_position = 57

func _ready():
	draw_scores()
	
func draw_scores():
	var dynamic_font = DynamicFont.new()
	dynamic_font.font_data = load("res://PressStart2P-vaV7.ttf")
	dynamic_font.size = FONT_SIZE
	
	for n in range(0, MAX_SCORES):
		
		# draw ranking (1st, 2nd etc)
		var label = Label.new()
		label.set_position(Vector2(RANK_X_POSITION, line_y_position))
		label.uppercase = true
		label.set("custom_fonts/font", dynamic_font)
		label.set_text(RANKING_NAMES[n])
		label.set("custom_colors/font_color", colour_for_line(n))
		add_child(label)
		
		# draw score placeholder value
		var score_label = Label.new()
		score_label.name = "score_" + str(n)
		score_label.set_position(Vector2(SCORE_X_POSITION, line_y_position))
		score_label.uppercase = true
		score_label.set("custom_fonts/font", dynamic_font)
		score_label.set_text(PLACEHOLDER_SCORE)
		score_label.set("custom_colors/font_color", colour_for_line(n))
		add_child(score_label)
		
		# draw PTS
		var pts_label = Label.new()
		pts_label.set_position(Vector2(PTS_X_POSITION, line_y_position))
		pts_label.uppercase = true
		pts_label.set("custom_fonts/font", dynamic_font)
		pts_label.set_text(POINTS_TEXT)
		pts_label.set("custom_colors/font_color", colour_for_line(n))
		add_child(pts_label)
		
		line_y_position += LINE_SPACING
	
	# draw header ranking text
	var header_label = Label.new()
	header_label.set("custom_fonts/font", dynamic_font)
	header_label.set_position(HEADER_POSITION)
	header_label.set_text(HEADER_TEXT)
	header_label.set("custom_colors/font_color", "e03d00")
	add_child(header_label)



func colour_for_line(line: int) -> String:
	match line:
		0,1,2: return COLOUR_TOP_ROWS
		3,4,5: return COLOUR_MID_ROWS
		_:     return COLOUR_LOW_ROWS
		
## NEED TO UPDATE HIGHSCORES AFTER SUBMIT
		
# connected via signal in Game.gd
func highscores_loaded(highscores: Array) -> void:
	for n in range(0, MAX_SCORES):
		get_node("score_"+str(n)).set_text(str(highscores[n]))
