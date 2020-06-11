extends Node2D

const max_spawned = 4

onready var enabled

func _ready():
	enabled = false

func enable():
	enabled = true
	
func disable():
	enabled = false
	
func _process(_delta):
	if enabled == true:
		pass
