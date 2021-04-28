

extends CanvasLayer

#onready var achievement_label_l1 = get_node("Control/Label_above")
onready var achievement_label_l2 = get_node("Control/Label_below")
onready var control = get_node("Control")

var current_stage: Reference # the current stage number
var achievement_sound: Reference # the play the sound
var save_achievements: Reference # the function that saves to disk
var get_achievements: Reference # retrieve the achievements
var demo_mode_check: Reference

var achievements: Dictionary
var tween: Tween
var tween_pointer = 0
var ground_targets_hit: = [] # this holds all the destroyed targets

# achievement 11 won't be possible if you lose a life
# this gets set via a signal call back - set via func _on_life_lost()
var life_lost:bool = false

# while the achievement title is displayed, flashing text is used, see _process
var flash_effect:bool = false
var flash_counter:int = 0

# achievements are added to a stack in order to queue other achievements
# during the current animation
var achievement_stack:Array = []

# the process function looks for any achievements added to the stack
# except while the animation is running by marking it as locked
var stack_lock:bool = false

# used by the tween function during animations
var achievement_in_progress: Dictionary

onready var tween_params = {
	0: {
		"label": get_node("Control/Label_above"),
		"property": "margin_top",
		"start_value": -8,
		"end_value": -16,
		"duration": 0.5,
		"hold_time": 1,
		"flash_on_hold": false
	},
	1: {
		"label": get_node("Control/Label_above"),
		"property": "margin_top",
		"start_value": -16,
		"end_value": -8,
		"duration": 0.5,
		"hold_time": 0,
		"flash_on_hold": false
	},
	2: {
		"label": get_node("Control/Label_below"),
		"property": "margin_top",
		"start_value": -24,
		"end_value": -16,
		"duration": 0.5,
		"hold_time": 5,
		"flash_on_hold": true
	},
	3: {
		"label": get_node("Control/Label_below"),
		"property": "margin_top",
		"start_value": -16,
		"end_value": -24,
		"duration": 0.5,
		"hold_time": 2,
		"flash_on_hold": false
	}
}


func _ready() -> void:
	control.visible = false
	yield(get_tree().create_timer(1), "timeout")
	tween = Tween.new()
	add_child(tween)
	var _a = tween.connect("tween_completed", self, "tween_completed")


func _on_achievements_loaded(loaded_achievements: Dictionary) -> void:
	achievements = loaded_achievements
	
	
func _process(_delta) -> void:
	if achievement_stack.size() > 0 and stack_lock == false:
		control.visible = true
		stack_lock = true
		achievement_in_progress = achievement_stack.pop_front()
		achievement_sound.call_func()
		achievement_label_l2.visible = true
		do_tween()
	
	if flash_effect == true:	
		flash_counter +=1
		if flash_counter>15:
			flash_counter = 0;
			achievement_label_l2.visible = !achievement_label_l2.visible
		

func _on_ground_target_destroyed(target: String, projectile: String) -> void:
	# don't record a target being destroyed by the ship
	if projectile != "Ship":
		ground_targets_hit.append ({
			'target_hit' : target,
			'projectile_used' : projectile,
			'stage' : current_stage.call_func()
		})
		
			
	# achievement 7 - destroy 10 or more fuel dumps on level 1
	if achievements[7].status == false:
		var fuel_count = 0
		if current_stage.call_func() == 1:
			for entry in ground_targets_hit:
				if entry.target_hit == "Fuel_dump" and entry.stage == 1:
					fuel_count += 1
					if fuel_count == 10:
						unlock_achievement(7)
						break
						
						
	# achievement 8 - destroy 30 enemies without using bombs
	if achievements[8].status == false:
		var count = 0
		for entry in ground_targets_hit:
			if entry.projectile_used == "Bullet":
				count += 1
				if count == 30:
					unlock_achievement(8)
					break
			else:
				count = 0
				
				
	# achievement 9 - destroy 30 enemies without using forward firing weapon
	if achievements[9].status == false:
		var count = 0
		for entry in ground_targets_hit:
			if entry.projectile_used == "Bomb":
				count += 1
				if count == 30:
					unlock_achievement(9)
					break
			else:
				count = 0
				
				
	# achievement 10 - destroy 5 or more mystery objects
	if achievements[10].status == false:
		var mystery_count = 0
		for entry in ground_targets_hit:
			if entry.target_hit == "Mystery":
				mystery_count += 1
				if mystery_count == 5:
					unlock_achievement(10)
					break
					
					
# called to prevent #11 from running
func _on_life_lost() -> void:
	life_lost = true
	
				
 # callbacks from signals created in game.gd
func _on_stage1_complete() -> void:
	unlock_achievement(1)
	
	
func _on_stage2_complete() -> void:
	unlock_achievement(2)
	
	
func _on_stage3_complete() -> void:
	unlock_achievement(3)


func _on_stage4_complete() -> void:
	unlock_achievement(4)
	
	
func _on_stage5_complete() -> void:
	unlock_achievement(5)
	
	
func _on_base_stage_complete() -> void:
	unlock_achievement(6)
	
	
func _on_game_complete() -> void:
	if life_lost == false:
		unlock_achievement(11)
		
		
func unlock_achievement(achievement_num: int) -> void:
	if achievements[achievement_num].status == false and demo_mode_check.call_func() == false:
		achievements[achievement_num].status = true
		achievements[achievement_num].date_unlocked = OS.get_datetime()
		achievement_stack.append(achievements[achievement_num])
		save_achievements.call_func()
		
		
func do_tween() -> void:
	get_node("Control/Label_below").text = achievement_in_progress.title
	var params = tween_params[tween_pointer]
	var _t = tween.interpolate_property(params.label, 
		params.property, params.start_value, params.end_value, params.duration,
		Tween.TRANS_LINEAR, Tween.EASE_IN)
	var _s = tween.start()
	

func tween_completed(_object,_key) -> void:
	flash_effect = tween_params[tween_pointer].flash_on_hold	
	var delay = tween_params[tween_pointer].hold_time
	yield(get_tree().create_timer(delay), "timeout")
	flash_effect = false
	achievement_label_l2.visible = true
	
	if tween_pointer != tween_params.size()-1:
		tween_pointer += 1
		do_tween()
	else:
		tween_pointer = 0
		stack_lock = false
		control.visible = false


# called at the end of the game to reset vars
func reset_vars() -> void:
	achievement_stack = []
	ground_targets_hit = []
	life_lost = false
	stack_lock = false
