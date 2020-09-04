extends Node2D

func _ready() -> void:
	reset()

func reset() -> void:
	for _node in $Animated_text.get_children():
		_node.visible_characters = 0
