extends Node

func _ready():
	randomize()

enum GameMode {
	RACE_WITH_TIME,
	RACE_WITH_FRIENDS
}

var last_selected_game_mode: int = GameMode.RACE_WITH_TIME
var last_number_of_rounds: int = 3
var last_selected_map: String = ""
var player_names: Array = ["", "", "", ""]

func get_non_empty_player_names() -> Array:
	var result = []
	for player_name in player_names:
		if player_name != "":
			result.append(player_name)
	return result
