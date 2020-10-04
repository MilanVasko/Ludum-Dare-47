extends Control

func _on_circle_map_pressed():
	Settings.last_selected_map = "circle"
	go_to_rounds_menu()

func _on_serpentines_map_pressed():
	Settings.last_selected_map = "serpentines"
	go_to_rounds_menu()

func go_to_rounds_menu():
	var err = get_tree().change_scene("res://main_menu/play_menu/rounds_menu/rounds_menu.tscn")
	assert(err == OK)

func _on_back_pressed():
	var err = get_tree().change_scene("res://main_menu/main_menu.tscn")
	assert(err == OK)
