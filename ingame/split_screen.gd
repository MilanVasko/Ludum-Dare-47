extends Node2D

func _ready():
	$CanvasLayer/GridContainer/ViewportContainer2/Viewport.world_2d = $CanvasLayer/GridContainer/ViewportContainer1/Viewport.world_2d
