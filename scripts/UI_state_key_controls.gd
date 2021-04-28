extends Node

signal escape_key_pressed

export(NodePath) var ui_node_path
onready var UI_screen = get_node(ui_node_path)

var is_active:bool = false

func _ready() -> void:
	UI_screen.visible = false
	
	
func enter() -> void:
	UI_screen.visible = true
	is_active = true


func _input(event):
	if is_active == true:
		if event.is_action_pressed("ui_cancel"):
			emit_signal("escape_key_pressed")		

	
func exit():
	UI_screen.visible = false
	is_active = false
