extends Node2D

#
# set up shortcuts to all nodes used in signal connections and func references
#
onready var Achievement_manager = get_node("/root/Scramble/Achievement_manager")
onready var Achievements = get_node("/root/Scramble/UI/Achievements")
onready var Base_container = get_node("Landscape_manager/Containers/Base_container")
onready var Bullet_container = get_node("Bullet_container")
onready var Bomb_container = get_node("Bomb_container")
onready var Tilemap_camera = get_node("Landscape_manager/Tilemap/Camera2D")
onready var Containers = get_node("Landscape_manager/Containers")
onready var Colour_manager = get_node("Colour_manager")
onready var Explosion_container = get_node("Explosion_container")
onready var Flag_holder = get_node("/root/Scramble/UI/Lower_hud/Flag_holder")
onready var Fireball_container = get_node("Landscape_manager/Containers/Fireball_container")
onready var Fuel_bar = get_node("/root/Scramble/UI/Lower_hud/Fuel_bar")
onready var Fuel_container = get_node("Landscape_manager/Containers/Fuel_container")
onready var Game_wipe = get_node("Wipe")
onready var Highscore_manager = get_node("/root/Scramble/Highscore_manager")
onready var Highscore_board = get_node("/root/Scramble/UI/UI_screens/Highscore_board")
onready var Land_manager = get_node("Landscape_manager")
onready var Landscape_decoder = get_node("Landscape_manager/Landscape_decoder")
onready var Lives = get_node("/root/Scramble/UI/Lower_hud/Lives")
onready var Lower_hud = get_node("/root/Scramble/UI/Lower_hud")
onready var Mystery_container = get_node("Landscape_manager/Containers/Mystery_container")
onready var Rocket_container = get_node("Landscape_manager/Containers/Rocket_container")
onready var Scene_factory = get_node("/root/Scramble/Scene_factory")
onready var Score_board = get_node("/root/Scramble/UI/Score_board")
onready var Ship = get_node("Ship")
onready var Sound_manager = get_node("/root/Scramble/Game/Sound_manager")
onready var Stage_board = get_node("/root/Scramble/UI/Stage_board")
onready var Starfield = get_node("/root/Scramble/UI/Starfield")
onready var State_machine = get_node("State_machine")

onready var State_achievements = get_node("State_machine/State_achievements")
onready var State_key_controls = get_node("State_machine/State_key_controls")
onready var State_settings = get_node("State_machine/State_settings")
onready var State_intro = get_node("State_machine/State_intro")

onready var State_player_starts = get_node("State_machine/State_player_starts")
onready var State_playing = get_node("State_machine/State_playing")
onready var State_demo_playing = get_node("State_machine/State_demo_playing")
onready var State_game_over = get_node("State_machine/State_game_over")
onready var State_game_over_high_scores = get_node("State_machine/State_game_over_high_scores")
onready var State_demo_over = get_node("State_machine/State_demo_over")
onready var State_crashed = get_node("State_machine/State_crashed")
onready var State_demo_crashed = get_node("State_machine/State_demo_crashed")
onready var State_mission_complete = get_node("State_machine/State_mission_complete")

onready var Tilemap = get_node("Landscape_manager/Tilemap")
onready var Ufo_container = get_node("Landscape_manager/Containers/Ufo_container")
onready var UI_state_machine = get_node("/root/Scramble/UI/UI_state_machine")
onready var UI_wipe = get_node("/root/Scramble/UI/Wipe")

#onready var UI_achievements = 
onready var UI_state_key_controls = get_node("/root/Scramble/UI/UI_state_machine/UI_state_key_controls")
onready var UI_state_settings = get_node("/root/Scramble/UI/UI_state_machine/UI_state_settings")
onready var UI_state_achievements = get_node("/root/Scramble/UI/UI_state_machine/UI_state_achievements")


onready var UI_screen_achievements = get_node("/root/Scramble/UI/UI_screens/Achievements")
onready var UI_screen_settings = get_node("/root/Scramble/UI/UI_screens/Settings")
onready var UI_screen_score_table = get_node("/root/Scramble/UI/UI_screens/Score_table")


func _ready():
	
	#
	# inject access to functions necessary in other scripts
	#
	
	UI_state_machine.turn_on_stars = funcref(Starfield, "turn_on_stars")
	UI_state_machine.turn_off_stars = funcref(Starfield, "turn_off_stars")
	
	UI_screen_achievements.interface_select_sound = funcref(Sound_manager, "play_interface_select_sound")
	
	UI_state_settings.select_text_up = funcref(UI_screen_settings, "select_text_up")
	UI_state_settings.select_text_down = funcref(UI_screen_settings, "select_text_down")
	UI_state_settings.get_selected_option = funcref(UI_screen_settings, "get_selected_option")
	UI_state_settings.show_ui_screen = funcref(UI_screen_settings, "show")
	UI_state_settings.hide_ui_screen = funcref(UI_screen_settings, "hide")

	UI_state_achievements.show_ui_screen = funcref(UI_screen_achievements, "show")
	UI_state_achievements.hide_ui_screen = funcref(UI_screen_achievements, "hide")	
	
	UI_state_achievements.select_achievement_right = funcref(UI_screen_achievements, "select_achievement_right")
	UI_state_achievements.select_achievement_left = funcref(UI_screen_achievements, "select_achievement_left")
		
	Achievements.demo_mode_check = funcref(State_machine, "is_demo_mode")
	Achievements.save_achievements = funcref(Achievement_manager, "save_achievements")
	Achievements.get_achievements = funcref(Achievement_manager, "get_achievements")
	
	Achievements.achievement_sound = funcref(Sound_manager, "play_achievement_sound")
	Achievements.current_stage = funcref(Landscape_decoder, "get_stage")
	Base_container.create_base = funcref(Scene_factory, "create_base")
	Bomb_container.spawn_explosion = funcref(Explosion_container, "spawn_explosion")
	Bomb_container.bomb_spawn_global_position = funcref(Ship, "bomb_spawn_position")
	Bomb_container.create_bomb = funcref(Scene_factory, "create_bomb")
	Bullet_container.bullet_spawn_global_position = funcref(Ship, "bullet_spawn_position")
	Bullet_container.create_bullet = funcref(Scene_factory, "create_bullet")
	Explosion_container.create_explosion = funcref(Scene_factory, "create_explosion")
	Fireball_container.create_fireball = funcref(Scene_factory, "create_fireball")
	Fireball_container.camera_property = funcref(Tilemap_camera, "get_camera_position") # add access to the camera position as a spawn location helper
	Fireball_container.fireball_sound = funcref(Sound_manager, "play_fireball_sound")
	Flag_holder.create_flag = funcref(Scene_factory, "create_flag")
	Fuel_container.spawn_explosion = funcref(Explosion_container, "spawn_explosion")
	Fuel_container.create_fuel = funcref(Scene_factory, "create_fuel")
	Fuel_container.explode_sound = funcref(Sound_manager, "play_multi_explosion_sound")
	Game_wipe.camera_property = funcref(Tilemap_camera ,"get_camera_position")
	Game_wipe.current_starfield = funcref(Starfield, "current_starfield")
	Lives.create_hud_ship = funcref(Scene_factory, "create_hud_life")
	Mystery_container.create_mystery = funcref(Scene_factory, "create_mystery")
	Mystery_container.explode_sound = funcref(Sound_manager, "play_multi_explosion_sound")
	Rocket_container.create_rocket = funcref(Scene_factory, "create_rocket")
	Rocket_container.rocket_takeoff_sound = funcref(Sound_manager, "play_rocket_takeoff_sound")
	Rocket_container.spawn_explosion = funcref(Explosion_container, "spawn_explosion")
	Score_board.demo_mode_check = funcref(State_machine, "is_demo_mode")
	Score_board.submit_highscore_property = funcref(Highscore_manager, "submit_score")
	
	State_crashed.stop_sounds = funcref(Sound_manager, "stop_all_sounds")
	State_crashed.camera_reset = funcref(Tilemap_camera, "reset")
	State_crashed.clear_landscape = funcref(Tilemap, "clear_landscape")
	State_crashed.clear_containers = funcref(Containers, "reset")
	State_crashed.ship_reset = funcref(Ship, "reset")
	State_crashed.landscape_restart = funcref(Land_manager, "stage_restart")
	State_crashed.lose_life = funcref(Lives, "lose_life")
	State_crashed.reset_fuel = funcref(Fuel_bar, "init")
	State_crashed.reset_bombs = funcref(Bomb_container, "reset")
	State_crashed.reset_bullets = funcref(Bullet_container, "reset")
	
	State_demo_playing.deplete_fuel = funcref(Fuel_bar, "deplete")
	State_demo_playing.move_player_forward = funcref(Ship, "move_forward")
	State_demo_playing.move_player_to_ground = funcref(Ship, "move_towards_ground")
	State_demo_playing.scroll_camera = funcref(Tilemap_camera, "scroll_right")
	State_demo_playing.update_landscape = funcref(Land_manager, "update_landscape")
	State_demo_playing.fire_button = funcref(Bullet_container, "fire_bullet")
	State_demo_playing.bomb_button = funcref(Bomb_container, "fire_bomb")
	State_demo_playing.move_left = funcref(Ship, "move_left")
	State_demo_playing.move_right = funcref(Ship, "move_right")
	State_demo_playing.move_up = funcref(Ship, "move_up")
	State_demo_playing.move_down = funcref(Ship, "move_down")
	State_demo_playing.reset_stage_board = funcref(Stage_board, "set_stage1")
	State_demo_playing.reset_colours = funcref(Colour_manager, "init")
	
	
	State_intro.reset_camera = funcref(Tilemap_camera, "reset")
	State_intro.turn_on_stars = funcref(Starfield, "turn_on_stars")
	

	
	
	
	
	State_game_over_high_scores.reset_score_board = funcref(Score_board, "reset")
	
	State_mission_complete.flag_earned = funcref(Flag_holder, "flag_earned")
	State_mission_complete.extra_life = funcref(Lives, "extra_life")
	
	State_player_starts.clear_flags = funcref(Flag_holder, "clear")
	State_player_starts.reset_stage_board = funcref(Stage_board, "set_stage1")
	State_player_starts.reset_land_manager = funcref(Land_manager, "reset")
	State_player_starts.reset_score_board = funcref(Score_board, "reset")
	State_player_starts.reset_colours = funcref(Colour_manager, "init")
	
	
	State_player_starts.start_music = funcref(Sound_manager, "play_start_music")
	State_player_starts.show_lives = funcref(Lives, "show_lives")
	State_player_starts.reset_lives = funcref(Lives, "reset")
	State_player_starts.flag_earned = funcref(Flag_holder, "flag_earned")	
	State_player_starts.reset_fuel = funcref(Fuel_bar, "init")
	
	State_player_starts.reset_bombs = funcref(Bomb_container, "reset")
	State_player_starts.reset_bullets = funcref(Bullet_container, "reset")
	

	State_playing.fire_button = funcref(Bullet_container, "fire_bullet")
	State_playing.bomb_button = funcref(Bomb_container, "fire_bomb")
	State_playing.move_left = funcref(Ship, "move_left")
	State_playing.move_right = funcref(Ship, "move_right")
	State_playing.move_up = funcref(Ship, "move_up")
	State_playing.move_down = funcref(Ship, "move_down")
	State_playing.add_score = funcref(Score_board, "add_score")	
	State_playing.missions_completed = funcref(Flag_holder, "get_missions_completed")	
	State_playing.move_player_forward = funcref(Ship, "move_forward") # used to keep player in line with camera
	State_playing.move_player_to_ground = funcref(Ship, "move_towards_ground") # used when player fuel is empty
	State_playing.scroll_camera = funcref(Tilemap_camera, "scroll_right")
	State_playing.update_landscape = funcref(Land_manager, "update_landscape")
	State_playing.deplete_fuel = funcref(Fuel_bar, "deplete")
	State_playing.current_stage = funcref(Landscape_decoder, "get_stage")
	State_playing.play_ambient_bg = funcref(Sound_manager, "play_ambient_bg")
	State_playing.play_ufo_sound = funcref(Sound_manager, "play_ufo_sound")
	
	Ufo_container.spawn_explosion = funcref(Explosion_container, "spawn_explosion")
	Ufo_container.camera_property = funcref(Tilemap_camera, "get_camera_position")
	Ufo_container.create_ufo = funcref(Scene_factory, "create_ufo")
	
	UI_wipe.current_starfield = funcref(Starfield, "current_starfield")
	UI_wipe.camera_property = funcref(Tilemap_camera ,"get_camera_position")
	
	#
	# set-up signal connections between nodes - all defined here in one location
	#
	
	# connections between game states and the UI screens
	State_machine.connect("state_intro_entered", UI_state_machine, "change_to_intro")	
	State_machine.connect("state_high_scores_entered", UI_state_machine, "change_to_high_scores")
	State_machine.connect("state_score_table_entered", UI_state_machine, "change_to_score_table")
	State_machine.connect("state_demo_playing_entered", UI_state_machine, "change_to_demo_playing")
	State_machine.connect("state_player_starts", UI_state_machine, "change_to_player_starts")
	State_machine.connect("state_playing_entered", UI_state_machine, "change_to_player_playing")
	State_machine.connect("state_game_over_entered", UI_state_machine, "change_to_game_over")
	State_machine.connect("state_game_over_high_scores_entered", UI_state_machine, "change_to_game_over_high_scores")
	State_machine.connect("state_mission_complete_entered", UI_state_machine, "change_to_mission_complete")
	State_machine.connect("state_key_controls_entered", UI_state_machine, "change_to_key_controls")
	State_machine.connect("state_settings_entered", UI_state_machine, "change_to_settings")
	State_machine.connect("state_achievements_entered", UI_state_machine, "change_to_achievements")
	

	# connect loading of achievements data file with UI nodes	
	Achievement_manager.connect("achievements_loaded", Achievements, "_on_achievements_loaded")	
	Achievement_manager.connect("achievements_loaded", UI_screen_achievements, "_on_achievements_loaded")
	
	
	Base_container.connect("base_was_hit", Achievements, "_on_game_complete")
	Base_container.connect("base_was_hit", Score_board, "add_score")
	Base_container.connect("base_was_hit", State_machine, "set_base_destroyed")
	Base_container.connect("mission_completed", State_machine, "set_mission_completed")
	
		
	Bomb_container.connect("bomb_hit_landscape", Sound_manager, "play_low_explosion")
	Bomb_container.connect("bomb_was_dropped", Sound_manager, "play_bomb_drop")
	Bullet_container.connect("bullet_was_fired", Sound_manager, "play_bullet_sound")
	
	Colour_manager.connect("colours_did_change", Tilemap, "change_colours")
	Colour_manager.connect("colours_did_change", Rocket_container, "change_colours")
	Colour_manager.connect("colours_did_change", Fuel_container, "change_colours")
	Colour_manager.connect("colours_did_change", Mystery_container, "change_colours")
	Colour_manager.connect("colours_did_change", Explosion_container, "change_colours")
	Colour_manager.connect("colours_did_change", Base_container, "change_colours")
	
	Fuel_bar.connect("fuel_low", Sound_manager, "play_low_fuel_sound")
	Fuel_bar.connect("fuel_restored", Sound_manager, "stop_low_fuel_sound")
	
	Fuel_container.connect("points_awarded", Score_board, "add_score")
	Fuel_container.connect("ground_target_destroyed", Achievements, "_on_ground_target_destroyed")
	Fuel_container.connect("fuel_restored", Fuel_bar, "restore")
	
	
	
	Highscore_manager.connect("highscores_loaded", Score_board, "highscores_loaded")  # add highscore to high score top label
	Highscore_manager.connect("highscores_loaded", Highscore_board, "highscores_loaded") # bring highscores off disk to highscore board
	Highscore_manager.connect("highscores_updated", Highscore_board, "highscores_loaded") # update highscore board after game
	
	
	Landscape_decoder.connect("stage1_completed", Rocket_container, "disable_rockets")
	Landscape_decoder.connect("stage1_completed", Starfield, "turn_off_stars")
	Landscape_decoder.connect("stage1_completed", Ufo_container, "enable")
	Landscape_decoder.connect("stage1_completed", Stage_board, "set_stage2")
	Landscape_decoder.connect("stage1_completed", Sound_manager, "play_ufo_sound")
	Landscape_decoder.connect("stage1_completed", Sound_manager, "stop_ambient_bg")
	Landscape_decoder.connect("stage1_completed", Achievements, "_on_stage1_complete")

	
	Landscape_decoder.connect("stage2_completed", Rocket_container, "disable_rockets")
	Landscape_decoder.connect("stage2_completed", Ufo_container, "disable")
	Landscape_decoder.connect("stage2_completed", Fireball_container, "enable")
	Landscape_decoder.connect("stage2_completed", Stage_board, "set_stage3")
	Landscape_decoder.connect("stage2_completed", Sound_manager, "stop_ufo_sound")
	Landscape_decoder.connect("stage2_completed", Achievements, "_on_stage2_complete")
	
	Landscape_decoder.connect("stage3_completed", Stage_board, "set_stage4")
	Landscape_decoder.connect("stage3_completed", Rocket_container, "enable_rockets")
	Landscape_decoder.connect("stage3_completed", Ufo_container, "disable")
	Landscape_decoder.connect("stage3_completed", Fireball_container, "disable")
	Landscape_decoder.connect("stage3_completed", Starfield, "turn_on_stars")
	Landscape_decoder.connect("stage3_completed", Sound_manager, "play_ambient_bg")
	Landscape_decoder.connect("stage3_completed", Achievements, "_on_stage3_complete")
	
	Landscape_decoder.connect("stage4_completed", Stage_board, "set_stage5")
	Landscape_decoder.connect("stage4_completed", Rocket_container, "enable_rockets")
	Landscape_decoder.connect("stage4_completed", Achievements, "_on_stage4_complete")
	
	Landscape_decoder.connect("stage5_completed", Stage_board, "set_stage6")
	Landscape_decoder.connect("stage5_completed", Achievements, "_on_stage5_complete")
	
	Lives.connect("lives_depleted", State_machine, "set_lives_depleted")
	State_machine.connect("state_playing_entered", State_machine, "clear_lives_depleted")
	
	Lives.connect("lives_depleted", Colour_manager, "disable")
	Lives.connect("lives_depleted", Tilemap, "clear_landscape")
	Lives.connect("lives_depleted", Containers, "reset")
	
	Mystery_container.connect("points_awarded", Score_board, "add_score")
	Mystery_container.connect("ground_target_destroyed", Achievements, "_on_ground_target_destroyed")
	
	
	Rocket_container.connect("points_awarded", Score_board, "add_score")
	Rocket_container.connect("rocket_was_hit", Sound_manager, "play_rocket_explosion")
	Rocket_container.connect("ground_target_destroyed", Achievements, "_on_ground_target_destroyed")
	
	Score_board.connect("extra_life_awarded", Lives, "extra_life")
	Score_board.connect("extra_life_awarded", Sound_manager, "play_extra_life_sound")
	
	Ship.connect("ship_was_hit", Colour_manager, "flash_colours")
	Ship.connect("ship_was_hit", Sound_manager, "stop_low_fuel_sound")
	Ship.connect("ship_was_hit", State_machine, "set_player_crashed")
	Ship.connect("ship_was_hit", Achievements, "_on_life_lost")
	
	Ship.connect("crash_animation_complete", Colour_manager, "clear_flash_colours")
	
	
	
	
	State_machine.connect("state_demo_playing_entered", Land_manager, "reset")	
	State_machine.connect("state_demo_playing_entered", Land_manager, "draw_runway")
	State_machine.connect("state_demo_playing_entered", Ship, "reset")
	State_machine.connect("state_demo_playing_entered", Fuel_bar, "init")
	State_machine.connect("state_demo_playing_entered", Sound_manager, "set_demo_mode")
	
	State_machine.connect("state_playing_entered", Sound_manager, "set_player_mode")
	State_machine.connect("state_playing_entered", Land_manager, "draw_runway")
	State_machine.connect("state_playing_entered", Colour_manager, "enable")
	State_machine.connect("state_playing_entered", Ship, "reset")
	
	State_machine.connect("state_game_over_entered", Ship, "hide")
	State_machine.connect("state_game_over_entered", Containers, "reset_targets")
	State_machine.connect("state_game_over_entered", Containers, "reset")
	State_machine.connect("state_game_over_entered", Colour_manager, "disable")
	State_machine.connect("state_game_over_entered", Score_board, "submit_highscore")
	State_machine.connect("state_game_over_entered", Achievements, "reset_vars")
	
		
	State_demo_over.connect("demo_did_end", Tilemap_camera, "reset")
	State_demo_over.connect("demo_did_end", Ship, "hide")
	State_demo_over.connect("demo_did_end", Tilemap, "clear_landscape")
	State_demo_over.connect("demo_did_end", Containers, "reset")
	
	State_machine.connect("state_mission_complete_entered", Ship, "hide")
	State_machine.connect("state_mission_complete_entered", Sound_manager, "stop_all_sounds")
	State_machine.connect("state_mission_complete_entered", Tilemap, "clear_landscape")
	State_machine.connect("state_mission_complete_entered", Containers, "reset")
	State_machine.connect("state_mission_complete_entered", Tilemap_camera, "reset")
	State_machine.connect("state_mission_complete_entered", Land_manager, "stage_restart")
	State_machine.connect("state_mission_complete_entered", Achievements, "_on_game_complete")

	Ufo_container.connect("ufo_was_hit", Score_board, "add_score")
	
	UI_state_settings.connect("option_selected", State_settings, "_on_selected_option")
	UI_state_key_controls.connect("escape_key_pressed", State_key_controls, "_on_escape_key")
	UI_state_achievements.connect("escape_key_pressed", State_achievements, "_on_escape_key")
