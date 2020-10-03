extends ViewportContainer

func set_world_2d(world_2d) -> void:
	$Viewport.world_2d = world_2d

func set_camera_index(index: int) -> void:
	$Viewport/Camera2D.index = index
