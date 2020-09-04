extends Node

onready var Rocket_container = get_node("/root/World/Containers/Rocket_container")
onready var Fuel_container = get_node("/root/World/Containers/Fuel_container")
onready var Mystery_container = get_node("/root/World/Containers/Mystery_container")
onready var Ufo_container = get_node("/root/World/Containers/Ufo_container")
onready var Fireball_container = get_node("/root/World/Containers/Fireball_container")
onready var Explosion_container = get_node("/root/World/Containers/Explosion_container")
onready var Base_container = get_node("/root/World/Containers/Base_container")

func update_ground_targets(data: Dictionary, xpos: int) -> void:
	if data.target_id != 0:
		match data.target_id:
			1: Rocket_container.add_rocket(Vector2(xpos, data.ypos - 2))
			2: Fuel_container.add_fuel(Vector2(xpos, data.ypos - 2))
			4: Mystery_container.add_mystery(Vector2(xpos, data.ypos - 2))
			8: Base_container.add_base(Vector2(xpos, data.ypos - 2))
