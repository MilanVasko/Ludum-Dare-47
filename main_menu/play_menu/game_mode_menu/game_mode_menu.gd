extends Control

func _on_race_with_time_pressed():
	Settings.last_selected_game_mode = Settings.GameMode.RACE_WITH_TIME
	var err = get_tree().change_scene("res://ingame/split_screen/split_screen.tscn")
	assert(err == OK)

func _on_race_with_friends_pressed():
	Settings.last_selected_game_mode = Settings.GameMode.RACE_WITH_FRIENDS
	var err = get_tree().change_scene("res://main_menu/play_menu/game_mode_menu/race_with_friends_menu/race_with_friends_menu.tscn")
	assert(err == OK)

func _on_back_pressed():
	var err = get_tree().change_scene("res://main_menu/play_menu/play_menu.tscn")
	assert(err == OK)
