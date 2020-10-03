extends Control

onready var summary = $Summary
onready var play = $Play

func _ready():
	var player_names = Settings.player_names
	assert(player_names.size() == 4)
	for i in range(player_names.size()):
		$HBoxContainer.get_child(i).set_player_name(player_names[i])
	update_summary(player_names)

func _on_back_pressed():
	var err = get_tree().change_scene("res://main_menu/game_mode_menu/game_mode_menu.tscn")
	assert(err == OK)

func _on_play_pressed():
	var err = get_tree().change_scene("res://ingame/split_screen/split_screen.tscn")
	assert(err == OK)

func _on_name_changed(index: int, new_name: String):
	Settings.player_names[index] = new_name
	update_summary(Settings.player_names)

func update_summary(names: Array) -> void:
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
