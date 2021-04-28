extends Node

const CYCLES_PER_FUEL_DRAIN = 20

var fsm: StateMachine
var fuel_drain_counter: int
var fuel_depleted: bool
var keystroke_pointer: int
var keystrokes: Array
var scroll_time: float


var deplete_fuel: Reference # add access to depleting fuel bar
var move_player_forward: Reference # normal move right (aligned with camera)
var move_player_to_ground:Reference # move player to ground when fuel is out
var scroll_camera: Reference
var update_landscape: Reference
var reset_stage_board: Reference

var fire_button: Reference
var bomb_button: Reference
var move_left: Reference
var move_right: Reference
var move_up: Reference
var move_down: Reference
var reset_colours: Reference


func init():
	fuel_depleted = false
	fuel_drain_counter = CYCLES_PER_FUEL_DRAIN
	keystroke_pointer = 0
	scroll_time = 0
	
	
func enter() -> void:
	fsm.demo_mode = true
	fsm.crashed = false
	keystroke_pointer = 0	
	keystrokes = load_recording()
	reset_stage_board.call_func()
	reset_colours.call_func()
	
	
func process(_delta) -> void:
	
	if not fsm.crashed == true:

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
			fuel_drain_counter = CYCLES_PER_FUEL_DRAIN
		
		scroll_camera.call_func()
		update_landscape.call_func()
	
		if keystroke_pointer < keystrokes.size():
			match keystrokes[keystroke_pointer]:
				"u": move_up.call_func()
				"d": move_down.call_func() 
				"l": move_left.call_func()
				"r": move_right.call_func()
				"f": fire_button.call_func()
				"b": bomb_button.call_func()
				
			keystroke_pointer += 1	
			
	else:
		exit("State_demo_crashed")

# allow start button during demo mode		
func unhandled_key_input(event) -> void:	
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ESCAPE:
			exit("State_demo_over")
	
	
func exit(next_state) -> void:
	fsm.change_to(next_state)
	
				
func load_recording():
	var file = File.new()
	if not file.file_exists("user://scramble_keystrokes.sav"):
		print("No file saved!")
		return
	# Open existing file
	if file.open("user://scramble_keystrokes.sav", File.READ) != 0:
		print("Error opening file")
		return

	# Get the data
	var data = parse_json(file.get_line())
	return data
