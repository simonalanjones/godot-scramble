extends Node

var demo_mode: bool

var interface_select_waveform = preload("res://sounds/interface_select.wav")
var interface_select_player = AudioStreamPlayer.new()

var achievement_waveform = preload("res://sounds/achievement.wav")
var achievement_player = AudioStreamPlayer.new()

var multi_explosion_waveform = preload("res://sounds/explosion_multi.wav")
var multi_explosion_player = AudioStreamPlayer.new()

var ambient_waveform = preload("res://sounds/ambient_bg.wav")
var ambient_sound_player = AudioStreamPlayer.new()

var bullet_waveform = preload("res://sounds/bullet.wav")
var bullet_sound_player = AudioStreamPlayer.new()

var low_explosion_waveform = preload("res://sounds/explosions/low explosion.wav")
var low_explosion_sound_player = AudioStreamPlayer.new()

var bomb_drop_waveform = preload("res://sounds/bomb drop.wav")
var bomb_drop_sound_player = AudioStreamPlayer.new()

var rocket_explosion_waveform = preload("res://sounds/explosions/rocket_explode.wav")
var rocket_explosion_player = AudioStreamPlayer.new()


var start_music_waveform = preload("res://sounds/scramble_start.wav")
var start_music_player = AudioStreamPlayer.new()

var low_fuel_waveform = preload("res://sounds/fuel_low.wav")
var low_fuel_player = AudioStreamPlayer.new()

var ufo_ambient_waveform = preload("res://sounds/ufo_ambient.wav")
var ufo_ambient_player = AudioStreamPlayer.new()

var fireball_waveform = preload("res://sounds/fireball4.wav")
var fireball_player = AudioStreamPlayer.new()

var rocket_takeoff_waveform = preload("res://sounds/rocket_takeoff.wav")
var rocket_takeoff_sound_player = AudioStreamPlayer.new()

var extra_life_waveform = preload("res://sounds/extra_life.wav")
var extra_life_sound_player = AudioStreamPlayer.new()



func _ready() -> void:
	
	interface_select_player.stream = interface_select_waveform
	self.add_child(interface_select_player)
	
	achievement_player.stream = extra_life_waveform
	self.add_child(achievement_player)
	
	extra_life_sound_player.stream = extra_life_waveform
	self.add_child(extra_life_sound_player)
	
	rocket_takeoff_sound_player.stream = rocket_takeoff_waveform 
	rocket_takeoff_sound_player.set_bus("Take_off")
	self.add_child(rocket_takeoff_sound_player)
	
	ambient_sound_player.stream = ambient_waveform 
	self.add_child(ambient_sound_player)
	
	bullet_sound_player.stream = bullet_waveform 
	self.add_child(bullet_sound_player)
	
	low_explosion_sound_player.stream = low_explosion_waveform 
	self.add_child(low_explosion_sound_player)
	
	bomb_drop_sound_player.stream = bomb_drop_waveform
	bomb_drop_sound_player.set_bus("Bomb_drop")
	self.add_child(bomb_drop_sound_player)
	
	rocket_explosion_player.stream = rocket_explosion_waveform 
	rocket_explosion_player.set_bus("Rocket_explode")
	self.add_child(rocket_explosion_player)
	
	low_fuel_player.stream = low_fuel_waveform 
	self.add_child(low_fuel_player)

	ufo_ambient_player.stream = ufo_ambient_waveform 
	self.add_child(ufo_ambient_player)	
	
	fireball_player.stream = fireball_waveform 
	self.add_child(fireball_player)
	
	multi_explosion_player.stream = multi_explosion_waveform
	self.add_child(multi_explosion_player)
	
	start_music_player.stream = start_music_waveform
	self.add_child(start_music_player)

# set via in connection in Game.gd
func set_demo_mode() -> void:
	demo_mode = true


# set via connection in Game.gd
func set_player_mode() -> void:
	demo_mode = false


func play_achievement_sound() -> void:
	achievement_player.play()
	
	
func play_multi_explosion_sound() -> void:
	if demo_mode == false:
		multi_explosion_player.play()
	

func play_rocket_takeoff_sound() -> void:
	if demo_mode == false:
		rocket_takeoff_sound_player.play()
			

func play_start_music() -> void:
	start_music_player.play()
	
	
func play_ambient_bg() -> void:
	if demo_mode == false && !ambient_sound_player.is_playing():
		ambient_sound_player.play()


# doesn't play during levels 2
func stop_ambient_bg() -> void:
	if ambient_sound_player.is_playing():
		ambient_sound_player.stop()
	
	
func play_low_explosion(_bomb: Object) -> void:
	if demo_mode == false:
		bomb_drop_sound_player.stop()
		low_explosion_sound_player.play()
		

func play_bomb_drop(_bomb: Object) -> void:
	if demo_mode == false:
		bomb_drop_sound_player.play()


func play_rocket_explosion(_points, _projectile) -> void:
	if demo_mode == false:
		rocket_explosion_player.play()		
			
			
func play_bullet_sound():
	if demo_mode == false:
		bullet_sound_player.set_pitch_scale(0.8)
		bullet_sound_player.play()


func play_ufo_sound() ->void:
	if demo_mode == false: # && !ufo_ambient_player.is_playing():
		ufo_ambient_player.play()

		
func stop_ufo_sound() -> void:
	if demo_mode == false: # && ufo_ambient_player.is_playing():
		ufo_ambient_player.stop()


func play_fireball_sound() -> void:
	fireball_player.play()
	

func stop_fireball_sound() -> void:
	fireball_player.stop()
				
	
func play_low_fuel_sound():
	if demo_mode == false  && !low_fuel_player.is_playing():
		low_fuel_player.play()


func stop_low_fuel_sound():
	if demo_mode == false: # && low_fuel_player.is_playing():
		low_fuel_player.stop()		

		
func play_extra_life_sound():
	extra_life_sound_player.play()


func play_interface_select_sound():
	interface_select_player.play()
	
	
func stop_all_sounds():
	ambient_sound_player.stop()
	low_fuel_player.stop()
	ufo_ambient_player.stop()
	fireball_player.stop()



