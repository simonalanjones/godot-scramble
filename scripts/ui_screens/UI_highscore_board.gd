extends "res://scripts/ui_screens/UI_view.gd"
tool

const RANKING_NAMES = [ 
	"1ST", "2ND", "3RD", "4TH", "5TH", "6TH", "7TH", "8TH", "9TH", "10TH"
	]
const POINTS_TEXT = "PTS"
const PLACEHOLDER_SCORE = "00000"
const HEADER_TEXT = "- SCORE RANKING -"
const HEADER_TEXT_COLOUR = "e03d00"

const COLOUR_TOP_ROWS = "e0e000"
const COLOUR_MID_ROWS = "00c3d9"
const COLOUR_LOW_ROWS = "8500d9"


func _ready():
	var grid_container = GridContainer.new()
	grid_container.set_columns(3)
	grid_container.set("custom_constants/hseparation", 8)
	grid_container.set("custom_constants/vseparation", 8)
	
	var top_mc = make_container_label(HEADER_TEXT, HEADER_TEXT_COLOUR)
	top_mc.set("custom_constants/margin_top", 32)
	top_mc.set("custom_constants/margin_bottom", 16)
	add_to_head(top_mc)
	
	
	for n in range(0, RANKING_NAMES.size()):
		# draw ranking (1st, 2nd etc)
		var label = make_label(RANKING_NAMES[n] + "  ", colour_for_line(n))
		grid_container.add_child(label)
		
		# draw score placeholder value
		var score_label = make_label(PLACEHOLDER_SCORE, colour_for_line(n))
		score_label.name = "score_" + str(n)
		score_label.add_to_group("highscores")
		grid_container.add_child(score_label)
		
		# draw PTS text
		var pts_label = make_label(POINTS_TEXT, colour_for_line(n))
		grid_container.add_child(pts_label)
		
	
	var grid_mc = MarginContainer.new()
	grid_mc.set("custom_constants/margin_left", 56)
	grid_mc.add_child(grid_container)
	add_to_body(grid_mc)
	#print(get_tree().get_nodes_in_group("highscores"))
	render()
	

func colour_for_line(line: int) -> String:
	match line:
		0,1,2: return COLOUR_TOP_ROWS
		3,4,5: return COLOUR_MID_ROWS
		_:     return COLOUR_LOW_ROWS
		
## NEED TO UPDATE HIGHSCORES AFTER SUBMIT
		
# connected via signal in Game.gd
func highscores_loaded(highscores: Array) -> void:
	var index = 0
	for node in get_tree().get_nodes_in_group("highscores"):
		node.set_text(str(highscores[index]))
		index += 1
