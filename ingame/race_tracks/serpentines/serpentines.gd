extends StaticBody2D

export(PackedScene) var player_scene: PackedScene

func _ready():
	match Settings.last_selected_game_mode:
		Settings.GameMode.RACE_WITH_TIME:
			# TODO: name
			spawn_player("Player", $PlayerSpawnPoints.get_children()[randi() % $PlayerSpawnPoints.get_child_count()])
		Settings.GameMode.RACE_WITH_FRIENDS:
			spawn_multiple_players($PlayerSpawnPoints.get_children())

func spawn_player(player_name: String, spawn_point: Node2D) -> void:
	var player = player_scene.instance()
	$Players.add_child(player)
	player.name = player_name
	player.global_position = spawn_point.global_position

func spawn_multiple_players(spawn_points: Array) -> void:
	var player_names = Settings.get_non_empty_player_names()
	for i in range(player_names.size()):
		spawn_player(player_names[i], spawn_points[i])
