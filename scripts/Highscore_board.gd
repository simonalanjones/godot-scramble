extends Node2D

signal highscores_loaded

# default high scores if saved data not available 
var high_scores:Array = [ 100, 100, 100, 100, 100, 100,
	100, 100, 101, 102 ]


func _ready():
	yield(get_tree(), "idle_frame")
	visible = false
	high_scores = load_scores()
	setup_board()
	
	
func setup_board():
	high_scores.sort_custom(self, "sort_descending")
	for n in range(0,10):
		get_node("score_"+str(n)).set_text(str(high_scores[n]))
	emit_signal('highscores_loaded')
		
			
func get_highscore()->int:
	return high_scores.max()
	
			
func submit_score(new_score):
	# sort to lowest first
	high_scores.sort_custom(self, "sort_ascending")

	var index = 0
	for score in high_scores:
		if new_score > score:
			high_scores[index] = new_score
			break
			
	# sort to highest first
	high_scores.sort_custom(self, "sort_descending")
	if not save_scores():
		print('error saving scores')
	setup_board()
	
	
func load_scores()->Array:
	var file = File.new()
	if not file.file_exists("user://saved_scores.sav"):
		print("No file saved!")
		return high_scores
		
	# Open existing file
	if file.open("user://saved_scores.sav", File.READ) != 0:
		print("Error opening high scores file")
		# return default highscores
		return high_scores

	var json = file.get_as_text()
	var json_result = JSON.parse(json).result
	var temp_high_scores = []

	for entry in json_result:
		temp_high_scores.append(entry)
		
	return temp_high_scores
		
		
func save_scores()->bool:
	var file = File.new()
	if file.open("user://saved_scores.sav", File.WRITE) != 0:
		print("Error opening file")
		return false
	file.store_string(to_json(high_scores))
	file.close()
	return true
	

func display_on():
	visible = true
	

func display_off():
	visible = false


func sort_ascending(a, b):
	return true if a < b else false
		
		
func sort_descending(a, b):
	return true if a > b else false
