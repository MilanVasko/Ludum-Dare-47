extends ViewportContainer

func set_world_2d(world_2d) -> void:
	$Viewport.world_2d = world_2d

func set_viewport_index(viewport_index: int) -> void:
	$Viewport/Camera2D.viewport_index = viewport_index
	$Viewport/CanvasLayer/IngameUI.viewport_index = viewport_index
