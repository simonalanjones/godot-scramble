extends Node2D

signal fuel_depleted
signal fuel_low

var fuel_drain_counter:int = 0

var fuel_remaining:int = 128 # double duty - width in pixels and counter
var enabled

var missions_completed:int = 0 #sent via World.gd

func _ready() -> void:
	enabled = true
	#var a = missions_completed_property.call_func()
	#print(a)
	#$Timer.start()

func calc_drain_rate() -> int:
	match missions_completed:
		0,1: return 20
		2: 	 return 16
		_: 	 return 12


func _process(_delta) -> void:
	fuel_drain_counter += 1
	if fuel_drain_counter == calc_drain_rate():
		fuel_drain_counter = 0
		#deplete()
		update()
		
	
func start() -> void:
	enabled = true


func stop() -> void:
	enabled = false
	
	
func update() -> void:
	var shader_param = 0.0078125*fuel_remaining
	$fuel.get_material().set_shader_param("width", shader_param)
	
	
func reset() -> void:
	fuel_remaining = 128
	update()
	
	
func restore(amount: int) -> void:
	fuel_remaining+=amount
	if fuel_remaining>128:
		fuel_remaining=128
	update()

		
func deplete() -> void:
	if enabled == true:
		fuel_remaining-=1
		if fuel_remaining<1:
			fuel_remaining = 0
			emit_signal("fuel_depleted")
		
func _on_Timer_timeout() -> void:
	if enabled == true:
		deplete()
		update()
		
		
func _on_Timer_fuel_check_timeout() -> void:
	if fuel_remaining<30:
		emit_signal("fuel_low")
