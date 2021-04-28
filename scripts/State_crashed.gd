# This node is a holding state while the ship crash animation plays
extends Node

var fsm: StateMachine


onready var UI_wait_timer =  get_node("/root/Scramble/Game/UI_wait_timer")

var camera_reset: Reference
var clear_landscape: Reference
var clear_containers: Reference
var ship_reset: Reference
var landscape_restart: Reference
var lose_life: Reference
var stop_sounds: Reference
var reset_fuel: Reference
var reset_bombs: Reference
var reset_bullets: Reference


func enter() -> void:
	
	#Input.start_joy_vibration(0 ,0.0, 1.0, 2)
		
	UI_wait_timer.start({
		'accept_input': [],
		'wait_time': 2	
	})
		
	yield(UI_wait_timer, "waiting_expired")
	stage_restart()
	
	
func stage_restart() -> void:
	stop_sounds.call_func()
	# look for mission complete/base hit status in state machine
	if fsm.mission_complete == true or fsm.base_destroyed == true:
		exit("State_mission_complete")
	else:
		lose_life.call_func()
	
		# don't restart if we got the signal all lives depleted	
		#if not all_lives_depleted:
		if not fsm.lives_depleted:
			camera_reset.call_func()
			clear_landscape.call_func()
			clear_containers.call_func()
			ship_reset.call_func()
			landscape_restart.call_func()
			
			reset_fuel.call_func()
			reset_bombs.call_func()
			reset_bullets.call_func()
			
			exit("State_playing")
		else:
			camera_reset.call_func()
			
			UI_wait_timer.start({
				'accept_input': [],
				'wait_time': .5	
			})
		
			yield(UI_wait_timer, "waiting_expired")
	
			exit("State_game_over")

			
func exit(next_state) -> void:
	fsm.crashed = false
	fsm.change_to(next_state)
