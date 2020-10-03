extends Control

func _on_circle_map_pressed():
	Settings.last_selected_map = "circle"
	go_to_game_mode_menu()

func go_to_game_mode_menu():
	var err = get_tree().change_scene("res://main_menu/game_mode_menu/game_mode_menu.tscn")
	assert(err == OK)

func _on_back_pressed():
	var err = get_tree().change_scene("res://main_menu/main_menu.tscn")
	assert(err == OK)
