#
# Make all main scene instancing happen in a single location
#

extends Node

onready var Rocket_scene: PackedScene = preload("res://scenes/enemy/Rocket_k2d.tscn")
onready var Fuel_scene: PackedScene = preload("res://scenes/enemy/Fuel.tscn")
onready var Mystery_scene: PackedScene = preload("res://scenes/enemy/Mystery.tscn")
onready var Bomb_scene: PackedScene = preload("res://scenes/player/Bomb.tscn")
onready var Bullet_scene: PackedScene = preload("res://scenes/player/Bullet.tscn")
onready var Ufo_scene: PackedScene = preload("res://scenes/enemy/Ufo.tscn")
onready var Fireball_scene: PackedScene = preload("res://scenes/enemy/Fireball.tscn")
onready var Base_scene: PackedScene = preload("res://scenes/enemy/Base.tscn")
onready var Explosion_scene: PackedScene = preload("res://scenes/enemy/Explosion.tscn")
onready var Flag_scene: PackedScene = preload("res://scenes/ui/Flag.tscn")
onready var Hud_life: PackedScene = preload("res://scenes/ui/Life.tscn")


func create_base():
	return Base_scene.instance()
	
	
func create_bomb():
	return Bomb_scene.instance()
	

func create_bullet():
	return Bullet_scene.instance()	


func create_explosion():
	return Explosion_scene.instance()


func create_fireball():
	return Fireball_scene.instance()
	

func create_flag():
	return Flag_scene.instance()	


func create_fuel():
	return Fuel_scene.instance()

		
func create_hud_life():
	return Hud_life.instance()


func create_mystery():
	return Mystery_scene.instance()
	
	
func create_rocket():
	return Rocket_scene.instance()


func create_ufo():
	return Ufo_scene.instance()
