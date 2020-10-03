extends Control

func _on_play_pressed():
	var err = get_tree().change_scene("res://main.tscn")
	assert(err == OK)
