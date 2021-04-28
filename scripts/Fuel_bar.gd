extends Node2D

signal fuel_low
signal fuel_restored

const MIN_FUEL = 1
const MAX_FUEL = 128
const FUEL_WARNING_LEVEL = 30
const FUEL_RESTORE_AMOUNT = 24
const FUEL_WIDTH_PER_UNIT = 0.0078125

var fuel_remaining: int # double duty - width in pixels and counter
var warning_flag: bool # used to indicate if low fuel signal already sent

func init():
	fuel_remaining = MAX_FUEL
	warning_flag = false
	update()
	
func deplete() -> int:
	fuel_remaining -= 1
	
	if fuel_remaining < MIN_FUEL:
		fuel_remaining = 0
		
	if fuel_remaining < FUEL_WARNING_LEVEL and warning_flag == false:
		emit_signal("fuel_low")
		warning_flag = true
		
	update()
	return fuel_remaining
	
	
func restore() -> void:
	fuel_remaining += FUEL_RESTORE_AMOUNT
	if fuel_remaining > MAX_FUEL:
		fuel_remaining = MAX_FUEL
	if fuel_remaining > FUEL_WARNING_LEVEL:
		emit_signal("fuel_restored")
		warning_flag = false	
	update()
	
	
func update() -> void:
	var shader_param = FUEL_WIDTH_PER_UNIT * fuel_remaining
	$fuel.get_material().set_shader_param("width", shader_param)
	
	
func reset() -> void:
	fuel_remaining = MAX_FUEL
	warning_flag = false
	emit_signal("fuel_restored")
	update()
	
		
func hide():
	visible = false
	
	
func show():
	visible = true
	reset()
