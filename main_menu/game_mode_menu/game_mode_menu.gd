extends Control

func _on_race_with_time_pressed():
	var err = get_tree().change_scene("res://ingame/main.tscn")
	assert(err == OK)

func _on_race_with_friends_pressed():
	var err = get_tree().change_scene("res://main_menu/game_mode_menu/race_with_friends_menu/race_with_friends_menu.tscn")
	assert(err == OK)

func _on_back_pressed():
	var err = get_tree().change_scene("res://main_menu/play_menu/play_menu.tscn")
	assert(err == OK)
