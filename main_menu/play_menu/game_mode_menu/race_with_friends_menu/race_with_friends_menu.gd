extends Control

onready var summary = $Summary
onready var play = $Play

func _ready():
	update_summary()

func _on_back_pressed():
	var err = get_tree().change_scene("res://main_menu/play_menu/game_mode_menu/game_mode_menu.tscn")
	assert(err == OK)

func _on_play_pressed():
	var err = get_tree().change_scene("res://ingame/split_screen/split_screen.tscn")
	assert(err == OK)

func on_player_name_changed(_index: int, _new_name: String):
	update_summary()

func update_summary() -> void:
	var non_empty_names = Settings.get_non_empty_player_names()

	if non_empty_names.size() < 2:
		play.visible = false
		summary.text = "Please specify at least two players."
	else:
		var result = "These players will race: " + non_empty_names[0]
		for i in range(1, len(non_empty_names) - 1):
			result += ", " + non_empty_names[i]
		result += " and " + non_empty_names[len(non_empty_names) - 1] + "."

		play.visible = true
		summary.text = result
