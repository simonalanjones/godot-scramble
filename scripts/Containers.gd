extends Node

onready var Rocket_container = get_node("Rocket_container")
onready var Fuel_container = get_node("Fuel_container")
onready var Mystery_container = get_node("Mystery_container")
onready var Ufo_container = get_node("Ufo_container")
onready var Fireball_container = get_node("Fireball_container")
onready var Base_container = get_node("Base_container")


func update_ground_targets(data: Dictionary, xpos: int) -> void:
	if data.target_id != 0:
		match data.target_id:
			1: Rocket_container.add_rocket(Vector2(xpos, data.ypos - 2))
			2: Fuel_container.add_fuel(Vector2(xpos, data.ypos - 2))
			4: Mystery_container.add_mystery(Vector2(xpos, data.ypos - 2))
			8: Base_container.add_base(Vector2(xpos, data.ypos - 2))

# when ending / restarting we should remove anything that has been instanced
func reset() -> void:
	for container in get_children():
		for item in container.get_children():
			item.queue_free()


func reset_targets():			
	Ufo_container.disable()
	Fireball_container.disable()
	Rocket_container.enable_rockets()
