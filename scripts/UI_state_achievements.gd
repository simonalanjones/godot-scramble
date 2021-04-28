extends Node

signal escape_key_pressed

var select_achievement_right: Reference
var select_achievement_left: Reference

var show_ui_screen: Reference
var hide_ui_screen: Reference

var is_active:bool = false


	

func enter():
	is_active = true
	show_ui_screen.call_func()

	
func exit():
	is_active = false
	hide_ui_screen.call_func()


func _input(event):
	if is_active == true:
		if event.is_action_pressed("ui_cancel"):
			emit_signal("escape_key_pressed")
			
			
		if event.is_action_pressed("ui_right"):
			select_achievement_right.call_func()
		elif event.is_action_pressed("ui_left"):			
			select_achievement_left.call_func()
			
#		elif event.is_action_pressed("ui_down"):
#			select_text_down.call_func()
#		elif event.is_action_pressed("ui_accept"):
#			var selected_option = get_selected_option.call_func()
#			emit_signal("option_selected", selected_option)
			
