extends Control

onready var rounds_node = $Container/Rounds/Value

func _ready():
	rounds_node.value = Settings.last_number_of_rounds

func _on_map_pressed(map_name: String) -> void:
	Settings.last_selected_map = map_name
	Settings.last_number_of_rounds = int(rounds_node.value)
	var err = get_tree().change_scene("res://main_menu/play_menu/game_mode_menu/game_mode_menu.tscn")
	assert(err == OK)

func _on_back_pressed():
	var err = get_tree().change_scene("res://main_menu/main_menu.tscn")
	assert(err == OK)
