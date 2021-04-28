#
# Manages the loading and saving of the highscores
#

extends Node

signal highscores_loaded
signal highscores_updated

const HIGH_SCORES_FILENAME: String = "user://saved_scores.sav"

# default high scores if saved data not available 
var high_scores:Array = [ 
	1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000
	]

	
func _ready() -> void:
	yield(read_scores_local(), "completed") # kick off the loading process
	emit_signal('highscores_loaded', get_highscores())
	
		
func read_scores_local() -> void:
	#yield(get_tree().create_timer(2.7), "timeout") #simulate network delay
	var file = File.new()
	if not file.file_exists(HIGH_SCORES_FILENAME):
		print("No file saved!")
		yield(get_tree(), "idle_frame")  # go with default scores
		
	# Open existing file
	if file.open(HIGH_SCORES_FILENAME, File.READ) != 0:
		print("Error opening high scores file")
		yield(get_tree(), "idle_frame")  # go with default scores
	
	else:
		
		var json = file.get_as_text()
		var json_result = JSON.parse(json).result
		var temp_high_scores:Array = []

		for entry in json_result:
			temp_high_scores.append(entry)
		
		high_scores = temp_high_scores
		yield(get_tree(), "idle_frame")
	

func get_highscore() -> int:
	return high_scores.max()
	
	
func get_highscores() -> Array:
	return high_scores


func submit_score(new_score: int) -> void:
	# sort to lowest first
	high_scores.sort_custom(self, "sort_ascending")

	var index = 0
	for score in high_scores:
		if new_score > score:
			high_scores[index] = new_score
			break
			
	# sort to highest first
	high_scores.sort_custom(self, "sort_descending")
	#var position = high_scores.find(new_score)
		
	if not save_scores() == true:
		print('error saving scores')
	else:
		emit_signal('highscores_updated', high_scores)
		
				
func save_scores() -> bool:
	var file = File.new()
	if file.open(HIGH_SCORES_FILENAME, File.WRITE) != 0:
		print("Error opening file")
		return false
	file.store_string(to_json(high_scores))
	file.close()
	return true
	

func sort_ascending(a, b) -> bool:
	return true if a < b else false
		
		
func sort_descending(a, b) -> bool:
	return true if a > b else false
