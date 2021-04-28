extends Node

# see function calc_fuel_drain_rate()
const FUEL_DRAIN_EASY = 20
const FUEL_DRAIN_MEDIUM = 16
const FUEL_DRAIN_HARD = 12

const POINTS_PER_SECOND = 10

var add_score: Reference # score board add points function reference
var current_stage: Reference # the current stage number
var deplete_fuel: Reference # add access to depleting fuel bar
var missions_completed: Reference
var move_player_forward: Reference # normal move right (aligned with camera)
var move_player_to_ground:Reference # move player to ground when fuel is out
var reset_lives: Reference
var scroll_camera: Reference
var update_landscape: Reference

var play_ambient_bg: Reference
var play_ufo_sound: Reference

var fire_button: Reference
var bomb_button: Reference
var move_left: Reference
var move_right: Reference
var move_up: Reference
var move_down: Reference


var current_missions_completed: int
var fuel_drain_counter: int
var fuel_depleted: bool
var recording: Array = []
var fsm: StateMachine
var scroll_time: float


func init():
	current_missions_completed = 0
	fuel_drain_counter = 0
	fuel_depleted = false
	scroll_time = 0
	
	
func enter() -> void: 
	fsm.demo_mode = false
	current_missions_completed = missions_completed.call_func()
	fuel_depleted = false
	fuel_drain_counter = calc_fuel_drain_rate()
	

	# start ambient sound
	match current_stage.call_func():
		1,3,4,5,6: play_ambient_bg.call_func()
		2: play_ufo_sound.call_func()
		
		
func process(delta) -> void:
	if fsm.mission_complete == true:
		exit('State_mission_complete')
	
	if not fsm.crashed == true:
		update_landscape.call_func()	
		scroll_camera.call_func()
			
		if not fuel_depleted:
			move_player_forward.call_func()
		else:
			move_player_to_ground.call_func()
		
		fuel_drain_counter -= 1
		if fuel_drain_counter <= 0:
			# deplete fuel and check remaining
			if deplete_fuel.call_func() <= 0:
				fuel_depleted = true
			# reset drain counter
			fuel_drain_counter = calc_fuel_drain_rate()
			
		# points added to score every second
		scroll_time += delta
		if scroll_time > 1:
			scroll_time = 0
			add_score.call_func(POINTS_PER_SECOND)
		
		
		## player movement and firing only if fuel remaining and not in demo
		if not fuel_depleted and fsm.demo_mode == false:
			var k = false
			
			if Input.is_action_pressed("ui_up"):
				recording.append("u")
				k = true
				move_up.call_func()
			if Input.is_action_pressed("ui_down"):
				recording.append("d")
				k = true
				move_down.call_func()
			if Input.is_action_pressed("ui_left"):
				recording.append("l")
				k = true
				move_left.call_func()
			if Input.is_action_pressed("ui_right"):
				recording.append("r")
				k = true
				move_right.call_func()
			
	
			# TAB key is fire bullet
			if Input.is_action_just_pressed("ui_focus_next"):
				k = true
				recording.append("f")
				fire_button.call_func()
			
			# SPC key to release bomb	
			if Input.is_action_just_released("ui_accept"):
				k = true
				recording.append("b")
				bomb_button.call_func()
				
			if k == false:
				recording.append("-")
	
	else:
		save_recording()	
		exit("State_crashed")
			
			
func exit(next_state) -> void:
	fsm.change_to(next_state)
		
				
func calc_fuel_drain_rate() -> int:
	match current_missions_completed:
		0, 1: return FUEL_DRAIN_EASY
		2: 	  return FUEL_DRAIN_MEDIUM
		_: 	  return FUEL_DRAIN_HARD
		
		
func fuel_has_depleted() -> void:
	fuel_depleted = true
	
		
func save_recording():
	var time = OS.get_system_time_secs()
	var filename: String = "user://scramble_keystrokes_" + str(time) + ".sav"
	var file = File.new()
	if file.open(filename, File.WRITE) != 0:
		print("Error opening file")
		return false
	file.store_string(to_json(recording))
	file.close()
