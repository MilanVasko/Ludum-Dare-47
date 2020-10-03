extends Control

func _on_play_pressed():
	var err = get_tree().change_scene("res://main_menu/play_menu/play_menu.tscn")
	assert(err == OK)
