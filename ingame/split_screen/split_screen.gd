extends Node2D

export(PackedScene) var viewport_container_scene: PackedScene

func _ready():
	if Settings.last_selected_game_mode == Settings.GameMode.RACE_WITH_FRIENDS:
		var player_names = Settings.get_non_empty_player_names()
		for i in range(player_names.size() - 1):
			var node: ViewportContainer = viewport_container_scene.instance()
			node.name = "ViewportContainer" + str(i + 1)
			node.set_viewport_index(i + 1)
			node.set_world_2d($CanvasLayer/GridContainer/ViewportContainer0/Viewport.world_2d)
			$CanvasLayer/GridContainer.add_child(node)
