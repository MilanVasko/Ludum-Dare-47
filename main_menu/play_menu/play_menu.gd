extends Control

func _on_race_with_time_pressed():
	var err = get_tree().change_scene("res://ingame/main.tscn")
	assert(err == OK)

func _on_race_with_friends_pressed():
	print("TODO")

func _on_back_pressed():
	var err = get_tree().change_scene("res://main_menu/main_menu.tscn")
	assert(err == OK)
