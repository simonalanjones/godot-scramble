extends Node2D

signal fuel_depleted
signal fuel_low

var fuel_drain_counter = 0

var fuel_remaining = 128 # double duty - width in pixels and counter
var enabled

var missions_completed = 0 #sent via World.gd

func _ready():
	enabled = true
	#var a = missions_completed_property.call_func()
	#print(a)
	#$Timer.start()

func calc_drain_rate():
	match missions_completed:
		0,1: 
			return 20
		2:
			return 16
		_:
			return 12


func _process(_delta):
		
	fuel_drain_counter += 1
	if fuel_drain_counter == calc_drain_rate():
		fuel_drain_counter = 0
		deplete()
		update()
		
	
func start():
	enabled = true


func stop():
	enabled = false
	
	
func update():
	var shader_param = 0.0078125*fuel_remaining
	$fuel.get_material().set_shader_param("width", shader_param)
	
	
func reset():
	fuel_remaining = 128
	update()
	
	
func restore(amount):
	fuel_remaining+=amount
	if fuel_remaining>128:
		fuel_remaining=128
	update()

		
func deplete():
	if enabled == true:
		fuel_remaining-=1
		if fuel_remaining<1:
			fuel_remaining = 0
			emit_signal("fuel_depleted")
		
func _on_Timer_timeout():
	if enabled == true:
		deplete()
		update()
		
		
func _on_Timer_fuel_check_timeout():
	if fuel_remaining<30:
		emit_signal("fuel_low")
