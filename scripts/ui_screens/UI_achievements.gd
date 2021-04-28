extends "res://scripts/ui_screens/UI_view.gd"
tool

const ACHIEVEMENTS_TEXT = "ACHIEVEMENTS"
const COMPLETED_TEXT = "COMPLETED"
const FONT_COLOUR = "ffffff"

var achievements
var selection_pointer = 1
var containers: = []
var interface_select_sound: Reference

var images = [
	preload("res://sprites/achievements/achievement_locked.png"),
	preload("res://sprites/achievements/achievement_01.png"),
	preload("res://sprites/achievements/achievement_02.png"),
	preload("res://sprites/achievements/achievement_03.png"),
	preload("res://sprites/achievements/achievement_04.png"),
	preload("res://sprites/achievements/achievement_05.png"),
	preload("res://sprites/achievements/achievement_06.png"),
	preload("res://sprites/achievements/achievement_07.png"),
	preload("res://sprites/achievements/achievement_08.png"),
	preload("res://sprites/achievements/achievement_09.png"),
	preload("res://sprites/achievements/achievement_10.png"),
	preload("res://sprites/achievements/achievement_11.png"),
]

onready var title_label = get_node("VBoxContainer/VBOX_container/title")
onready var desc_label = get_node("VBoxContainer/VBOX_container/description")
onready var texture_holder = get_node("VBoxContainer/VBOX_container/CenterContainer/image")
onready var unlocked_date_label = get_node("VBoxContainer/VBOX_container/date_unlocked")


func _on_achievements_loaded(loaded_achievements: Dictionary) -> void:
	achievements = loaded_achievements
	var mc = make_container_label(ACHIEVEMENTS_TEXT, FONT_COLOUR)
	mc.set("custom_constants/margin_top", 28)
	add_to_head(mc)
	
	var my_label = make_container_label(achievements[selection_pointer].title, FONT_COLOUR)
	my_label.set("custom_constants/margin_top", 28)
	containers.append(my_label)
	var my_label2 = make_container_label(achievements[selection_pointer].description, FONT_COLOUR)
	my_label2.set("custom_constants/margin_top", 8)
	containers.append(my_label2)


func select_achievement_right():
	if selection_pointer < achievements.size():
		selection_pointer += 1
		update_labels()
		update_image()
		interface_select_sound.call_func()


func select_achievement_left():
	if selection_pointer > 1:
		selection_pointer -= 1
		update_labels()
		update_image()
		interface_select_sound.call_func()


func update_image():
	#if achievements[selection_pointer].status == true:
	texture_holder.texture = images[selection_pointer]
	#else:
	#	texture_holder.texture = images[0]
	
	
func update_labels():
	title_label.text = achievements[selection_pointer].title
	desc_label.text = achievements[selection_pointer].description

	if achievements[selection_pointer].date_unlocked.has("day"):
		var day_unlocked = str(achievements[selection_pointer].date_unlocked.day)
		var month_unlocked = str(achievements[selection_pointer].date_unlocked.month)
		var year_unlocked = str(achievements[selection_pointer].date_unlocked.year)
		unlocked_date_label.text = COMPLETED_TEXT + " " + day_unlocked + "/" + month_unlocked + "/"	+ year_unlocked
	else:
		unlocked_date_label.text = ""
	
	
func _init() -> void:
	visible = false


func _on_visibility_changed() -> void:
	selection_pointer = 1
	update_labels()
	update_image()
