extends Node

signal achievements_loaded

const ACHIEVEMENTS_FILENAME: String = "user://saved_achievements.sav"

var achievements: Dictionary = {
	1: {
		"status" : false,
		"title" : "stage 1 complete",
		"description" : "made it through the 1st stage",
		"date_unlocked" : []
	},
	2: {
		"status" : false,
		"title" : "stage 2 complete",
		"description" : "made it through the 2nd stage",
		"date_unlocked" : []
	},
	3: {
		"status" : false,
		"title" : "stage 3 complete",
		"description" : "made it through the 3rd stage",
		"date_unlocked" : []
	},
	4: {
		"status" : false,
		"title" : "stage 4 complete",
		"description" : "made it through the 4th stage",
		"date_unlocked" : []
	},
	5: {
		"status" : false,
		"title" : "stage 5 complete",
		"description" : "made it through the 5th stage",
		"date_unlocked" : []
	},
	6: {
		"status" : false,
		"title" : "base stage complete",
		"description" : "destroyed the base",
		"date_unlocked" : []
	},
	7: {
		"status" : false,
		"title" : "fuel mastery",
		"description" : "destroyed 10 or more fuel dumps on the 1st stage",
		"date_unlocked" : []
	},
	8: {
		"status" : false,
		"title" : "sharp shooter",
		"description" : "destroyed 30 enemies without once dropping a bomb",
		"date_unlocked" : []
	},
	9: {
		"status" : false,
		"title" : "bombing run",
		"description" : "destroyed 30 enemies without using your forward firing weapon",
		"date_unlocked" : []
	},
	10: {
		"status" : false,
		"title" : "enjoying the mystery",
		"description" : "destroyed 5 or more mystery objects",
		"date_unlocked" : []
	},
	11: {
		"status" : false,
		"title" : "sheer perfection",
		"description" : "completed all the stages without losing a life",
		"date_unlocked" : []
	}
}


func _ready() -> void:
	yield(read_achievements_local(), "completed") # kick off the loading process
	emit_signal('achievements_loaded', get_achievements())


func save_achievements() -> bool:
	var file = File.new()
	if file.open(ACHIEVEMENTS_FILENAME, File.WRITE) != 0:
		print("Error opening file")
		return false
	file.store_string(to_json(achievements))
	file.close()
	return true	
	

func read_achievements_local() -> void:
	#yield(get_tree().create_timer(2.7), "timeout") #simulate network delay
	var file = File.new()
	if not file.file_exists(ACHIEVEMENTS_FILENAME):
		print("No file saved!")
		yield(get_tree(), "idle_frame")  # go with default achievements
		
	# Open existing file
	if file.open(ACHIEVEMENTS_FILENAME, File.READ) != 0:
		print("Error opening achievements file")
		yield(get_tree(), "idle_frame")  # go with default achievements
	
	else:
		var json = file.get_as_text()
		var json_result = JSON.parse(json).result
		
		var _achievements: Dictionary = {}
		var index = 1
		for a in json_result.values():
			_achievements[index] = a
			index += 1
		achievements = _achievements
		yield(get_tree(), "idle_frame")

	

func get_achievements() -> Dictionary:
	return achievements
