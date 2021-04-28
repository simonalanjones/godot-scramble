extends Node

signal waiting_expired

var key_list: Array

func _ready() -> void:
	var wait_timer = Timer.new()
	wait_timer.name = "my_timer"
	wait_timer.autostart = false
	wait_timer.one_shot = true
	if wait_timer.connect("timeout", self, "do_timeout") == OK:
		add_child(wait_timer)


func _unhandled_input(event) -> void:
	if not get_node("my_timer").is_stopped() and key_list.size() > 0:
		for key in key_list:
			if InputMap.has_action(key) and event.is_action_released(key):
				do_timeout(key)
				
							
func start(params: Dictionary) -> void:
	if "accept_input" in params:
		key_list = params.accept_input
		
	var wait_timer = get_node("my_timer")
	wait_timer.wait_time = params.wait_time
	wait_timer.start()
	
	
func do_timeout(key = null) -> void:
	get_node('my_timer').stop()
	emit_signal("waiting_expired", key)
