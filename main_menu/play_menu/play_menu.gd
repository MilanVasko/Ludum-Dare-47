extends Control

onready var rounds_node = $Container/Rounds/Value

func _ready():
	rounds_node.value = Settings.last_number_of_rounds

func _on_circle_map_pressed():
	Settings.last_selected_map = "circle"
	go_to_game_mode_menu()

func _on_serpentines_map_pressed():
	Settings.last_selected_map = "serpentines"
	go_to_game_mode_menu()

func _on_square_map_pressed():
	Settings.last_selected_map = "square"
	go_to_game_mode_menu()

func go_to_game_mode_menu():
	Settings.last_number_of_rounds = int(rounds_node.value)
	var err = get_tree().change_scene("res://main_menu/play_menu/game_mode_menu/game_mode_menu.tscn")
	assert(err == OK)

func _on_back_pressed():
	var err = get_tree().change_scene("res://main_menu/main_menu.tscn")
	assert(err == OK)
